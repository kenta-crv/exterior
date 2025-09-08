class CreateEstimates < ActiveRecord::Migration[5.2]
  def change
    create_table :estimates do |t|
      t.string :name  #名前
      t.date :birth  #名前
      t.string :tel #電話番号
      t.string :postnumber #郵便番号
      t.string :prefecture #都道府県
      t.string :city #市町村
      t.string :city2 #番地
      t.string :building #ビル名
      t.string :email #メールアドレス
      t.string :which_one #使いたい機能
      t.string :period #導入時期
      t.string :remarks #その他
      t.timestamps
    end
  end
end
