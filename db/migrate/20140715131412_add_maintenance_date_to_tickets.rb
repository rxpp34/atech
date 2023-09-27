class AddMaintenanceDateToTickets < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :maintenance_date, :date
  end
end
