ActiveAdmin.register UncategorizedAsset do

  menu parent: 'Objets'

  filter :client
  filter :name
  filter :description
  filter :expiration_date

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client)
    end
  end

  index do
    column :client
    column :name
    column :expiration_date do |resource|
      l resource.expiration_date, format: :long
    end

    actions
  end

  show do
    attributes_table do
      row :client
      row :name
      row :expiration_date do
        l resource.expiration_date, format: :long
      end
      row :description do
        simple_format resource.description
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :client
      f.input :name
      f.input :expiration_date, as: :datepicker
      f.input :description
    end

    f.actions
  end

end
