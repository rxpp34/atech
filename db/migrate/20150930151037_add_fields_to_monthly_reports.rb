class AddFieldsToMonthlyReports < ActiveRecord::Migration
  def change
    add_column :monthly_reports, :hard_drives_state, :string, default: 'Ok'
    add_column :monthly_reports, :hard_drives_down, :integer, default: 0
    add_column :monthly_reports, :software_working, :boolean, default: true, null: false
    add_column :monthly_reports, :licence_up_to_date, :boolean, default: true, null: false
  end
end
