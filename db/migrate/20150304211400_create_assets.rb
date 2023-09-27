class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :client
      t.string :name
      t.text :description
      t.date :expiration_date

      t.timestamps
    end
    add_index :assets, :client_id
  end
end
