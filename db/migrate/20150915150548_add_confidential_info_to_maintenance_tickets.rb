class AddConfidentialInfoToMaintenanceTickets < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :confidential_info, :text
  end
end
