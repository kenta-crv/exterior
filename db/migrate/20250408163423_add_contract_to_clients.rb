class AddContractToClients < ActiveRecord::Migration[5.2]
  def change
    add_reference :clients, :contract, foreign_key: true
  end
end
