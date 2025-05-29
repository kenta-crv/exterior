class CreateAdvances < ActiveRecord::Migration[5.2]
  def change
    create_table :advances do |t|
      t.references :contract, null: false, foreign_key: true
      t.string :status
      t.datetime :next
      t.string :body
      t.timestamps
    end
  end
end
