class AddClientIdToMaintenanceTicket < ActiveRecord::Migration
  def up
    change_table(:maintenance_tickets) do |t|
      t.belongs_to :client
      t.remove :client_name, :client_email
    end
  end

  def down
    change_table(:maintenance_tickets) do |t|
      t.remove :client_id
      t.string :client_name, :client_email
    end
  end
end
