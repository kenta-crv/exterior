class AddColumnToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :face, :string
    add_column :clients, :logo, :string
    add_column :clients, :before_1, :string
    add_column :clients, :after_1, :string
    add_column :clients, :before_2, :string
    add_column :clients, :after_2, :string
    add_column :clients, :before_3, :string
    add_column :clients, :other_1, :string
    add_column :clients, :other_2, :string
    add_column :clients, :other_3, :string
  end
end
