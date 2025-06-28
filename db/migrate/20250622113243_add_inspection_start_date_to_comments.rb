class AddInspectionStartDateToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :inspection_start_date, :date
    add_column :comments, :status, :string
    add_column :comments, :status_info, :string
    add_column :comments, :file, :string
    add_column :comments, :remarks, :string
  end
end
