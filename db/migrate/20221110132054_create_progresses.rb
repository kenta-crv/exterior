class CreateProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :progresses do |t|
      t.references :estimate, foreign_key: true
      t.string :status
      t.string :body
      t.integer :admin_id
      t.string :document
      t.date :next
      t.timestamps
    end
  end
end
