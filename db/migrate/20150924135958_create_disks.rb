class CreateDisks < ActiveRecord::Migration
  def change
    create_table :disks do |t|
      t.string :name
      t.integer :total_storage, default: 0
      t.integer :used_storage, default: 0
      t.references :server_asset, index: true

      t.timestamps null: false
    end
  end
end
