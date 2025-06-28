class AddNetInfoToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :net_info, :jsonb
  end
end
