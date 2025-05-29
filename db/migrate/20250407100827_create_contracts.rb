class CreateContracts < ActiveRecord::Migration[5.2]
  def change
    create_table :contracts do |t|
      #問い合わせ項目
      t.string :company #会社名
      t.string :name #担当者
      t.string :tel #電話番号
      t.string :email #メールアドレス
      t.string :address #所在地
      t.string :period #導入希望時期
      t.string :area #導入希望エリア
      t.string :message #備考
      #契約情報
      t.string :post_title #代表取締役
      t.string :president_name #代表取締役
      t.string :agree #契約同意
      t.string :contract_date #契約日
      t.timestamps
    end
  end
end
