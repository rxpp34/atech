class AddStateToDisks < ActiveRecord::Migration
  def change
    add_column :disks, :state, :string
  end
end
