class SetDefaultAssignedToOnMaintenanceTickets < ActiveRecord::Migration

  class MaintenanceTicket < ActiveRecord::Base
  end

  def change
    rename_column :maintenance_tickets,
                  :assigned_to,
                  :assigned_to_old

    add_column :maintenance_tickets,
               :assigned_to,
               :string,
               array: true,
               default: ['Volodia']

    MaintenanceTicket.find_each do |ticket|
      next if ticket.assigned_to_old.blank?
      assignees = '{' +
                  ticket
                  .assigned_to_old
                  .split(',')
                  .map(&:titleize)
                  .map(&:strip)
                  .join(',')
                  .gsub('Jerome', 'Jérôme')
                  .gsub('Damiein', 'Damien')
                  .gsub('Thieery', 'Thierry')
                  .gsub(' ', ',') +
                  '}'

      ticket.update_column :assigned_to, assignees
    end

    remove_column :maintenance_tickets,
                  :assigned_to_old
  end
end
