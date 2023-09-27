ActiveAdmin.register DomainAsset do

  menu parent: 'Objets'

  filter :client
  filter :name
  filter :expiration_date
  filter :description

  controller do
    def scoped_collection
      end_of_association_chain.includes(:client)
    end
  end

  index do
    column :client
    column :name
    column :quantity
    column :expiration_date do |resource|
      l resource.expiration_date, format: :long
    end
    actions
  end

  show do
    attributes_table do
      row :client
      row :name
      row :quantity
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
      f.input :quantity
      f.input :expiration_date, as: :datepicker
      f.input :description
    end

    f.actions
  end

end
