class DoNotSendEmailToTickets < ActiveRecord::Migration
  def change
    add_column :maintenance_tickets, :do_not_send_email, :boolean, default: false
  end
end
