ActiveAdmin.register AdminUser do

  menu priority: 4, label: 'Administrateurs'

  config.filters = false

  actions :all, except: [:delete, :show]

  index do
    column :username
    actions
  end

  form do |f|
    f.inputs do
      f.input :email
      f.input :username
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end

end
