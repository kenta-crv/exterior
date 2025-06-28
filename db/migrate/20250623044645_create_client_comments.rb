class CreateClientComments < ActiveRecord::Migration[5.2]
  def change
    create_table :client_comments do |t|
      t.references :estimate, foreign_key: true
      t.references :client, foreign_key: true
      t.string :status
      t.text :remarks
      t.date :sent_date
      t.date :inspection_start_date

      t.timestamps
    end
  end
end
