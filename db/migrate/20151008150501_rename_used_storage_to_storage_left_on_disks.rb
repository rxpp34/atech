class RenameUsedStorageToStorageLeftOnDisks < ActiveRecord::Migration
  def change
    remove_column :disks, :used_storage
    add_column :disks, :storage_left, :integer
  end
end
