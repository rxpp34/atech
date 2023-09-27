class CreateMonthlyReports < ActiveRecord::Migration
  def change
    create_table :monthly_reports do |t|
      t.references :server_asset, index: true
      t.date :date
      t.string :pdf
      t.string :tech, default: 'Thierry'
      t.string :last_backup_state
      t.text :last_backup_reason
      t.string :previous_backups_state
      t.text :previous_backups_reason
      t.string :restore_state
      t.text :restore_reason
      t.text :notes

      t.timestamps null: false
    end
  end
end
