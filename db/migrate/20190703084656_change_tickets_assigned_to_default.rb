class ChangeTicketsAssignedToDefault < ActiveRecord::Migration
  def up
    change_column_default(:maintenance_tickets, :assigned_to, [])
  end

  def down
    change_column_default(:maintenance_tickets, :assigned_to, ["Volodia"])
  end
end
