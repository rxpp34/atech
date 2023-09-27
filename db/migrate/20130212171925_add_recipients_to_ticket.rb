class AddRecipientsToTicket < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :recipients, :string
  end
end
