class AddDescriptionToMaintenanceTickets < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :description, :text
  end
end
