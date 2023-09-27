class AddUnderContractToClients < ActiveRecord::Migration
  def change
    add_column :clients, :under_contract, :boolean, default: false
  end
end
