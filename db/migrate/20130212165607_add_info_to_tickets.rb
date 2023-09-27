class AddInfoToTickets < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :assigned_to, :string
    add_column :maintenance_tickets, :duration, :string
  end
end
