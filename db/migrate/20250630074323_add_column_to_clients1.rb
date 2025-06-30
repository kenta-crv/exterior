class AddColumnToClients1 < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :after_3, :string
  end
end
