class CreateMaintenanceTickets < ActiveRecord::Migration
  def change
    create_table :maintenance_tickets do |t|
      t.string :maintained_by
      t.string :client_name
      t.string :client_email
      t.text :comment
      t.string :state

      t.timestamps
    end
  end
end
