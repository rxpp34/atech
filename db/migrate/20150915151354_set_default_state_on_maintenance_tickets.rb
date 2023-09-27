class SetDefaultStateOnMaintenanceTickets < ActiveRecord::Migration
  def change
    change_column :maintenance_tickets,
                  :state,
                  :string,
                  default: 'Ouvert - Urgent'
  end
end
