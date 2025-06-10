class AddColumnToClient < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :post_title, :string #役職
    add_column :clients, :agree, :string #同意
    add_column :clients, :contract_date, :date #契約日
  end
end
