ActiveAdmin.register ServerAsset do

  menu parent: 'Objets'

  filter :client
  filter :name
  filter :description

  config.sort_order = 'lastest_monthly_report_date_asc'

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client)
    end

    def index
      index! do

        @collection =
          collection
          .select('assets.*,'\
                  'max(monthly_reports.date) as lastest_monthly_report_date')
          .joins('LEFT OUTER JOIN "monthly_reports"'\
                 'ON "monthly_reports"."server_asset_id" = "assets"."id"')
          .group('assets.id')

      end
    end
  end

  index do
    column :client
    column :name
    column :description do |resource|
      simple_format resource.description
    end
    column :expiration_date do |resource|
      ldate resource.expiration_date, format: :long
    end
    column 'Dernière VM', sortable: 'lastest_monthly_report_date' do |resource|
      ldate resource.lastest_monthly_report_date, format: '%B %Y'
    end

    actions do |resource|
      link_to MonthlyReport.model_name.human(count: 2),
              admin_server_asset_monthly_reports_path(resource),
              class: 'member_link'
    end
  end

  show do
    attributes_table do
      row :client
      row :name
      row :description do
        simple_format resource.description
      end
      row :quantity do
        server_memory resource
      end
      row :expiration_date do
        ldate resource.expiration_date, format: :long
      end
    end

    panel Disk.model_name.human(count: resource.disks.size) do
      table_for resource.disks.order(:name) do
        column 'Partition', :name
        column 'Capacité totale' do |r|
          "#{r.total_storage} Go" if r.total_storage
        end
        column 'Capacité restante' do |r|
          "#{r.storage_left || r.total_storage} Go"
        end
        column 'État', :state
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :client
      f.input :name
      f.input :description
      f.input :quantity, hint: 'Go'
      f.input :expiration_date, as: :datepicker
    end

    f.has_many :disks, allow_destroy: true do |ff|
      ff.input :name
      ff.input :total_storage, hint: 'Go'
      ff.input :storage_left, hint: 'Go'
      ff.input :state, as: :radio, collection: Disk::STATES
    end

    f.actions
  end

end
