class AddColumnToAgrees < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :agree_1, :string
    add_column :clients, :agree_2, :string
    add_column :clients, :agree_3, :string
    add_column :clients, :agree_4, :string
    add_column :clients, :agree_5, :string
    add_column :clients, :agree_6, :string
    add_column :clients, :agree_7, :string
    add_column :clients, :agree_8, :string
    add_column :clients, :agree_9, :string
  end
end
