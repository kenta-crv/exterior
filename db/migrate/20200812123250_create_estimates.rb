class CreateEstimates < ActiveRecord::Migration[5.2]
  def change
    create_table :estimates do |t|
      t.string :co #会社名
      t.string :name  #名前
      t.string :tel #電話番号
      t.string :postnumber #郵便番号
      t.string :address #施工先住所
      t.string :email #メールアドレス
      t.string :which_one #新築or改築
      t.string :square_meter #平米
      t.string :schedule #施工予定月
      t.string :bring #既に他社で見積もりや図面を取得しているか？
      t.string :importance #施工決定における重要点
      t.string :period #いつまでに決めたいか
      t.string :remarks #要望
      t.integer :user_id
      t.boolean :send_mail_flag, default: false
      t.boolean :disclosed
      t.boolean :accepted_by_client

      t.timestamps
    end
  end
end
