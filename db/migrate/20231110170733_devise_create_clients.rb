# frozen_string_literal: true

class DeviseCreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      t.string  :company                     # 会社名
      t.string :representative_name
      t.string :representative_kana
      t.string :contact_name
      t.string :contact_kana
      t.string  :tel                         # 携帯番号
      t.string  :address                     # 所在地
      t.string  :url                         # 会社URL
      t.string  :area                        # 対応可能エリア
      
      # ヒアリングフォーム
      t.string  :question_area              # 「はい」「いいえ」 ラジオボタン
      t.string  :question_price             # 「はい」「いいえ」 ラジオボタン
      t.string  :question_tax               # 「問題ありません」 チェックボックス
      t.string  :question_responce          # 「問題ありません」 チェックボックス
      t.string  :question_contract          # 「問題ありません」 チェックボックス（または text にするなら変更）
      t.string  :question_picture           # 「はい」「いいえ」 ラジオボタン
      t.text    :question_appeal            # アピールテキスト（50文字以上）
      
      t.timestamps

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :clients, :email,                unique: true
    add_index :clients, :reset_password_token, unique: true
    # add_index :clients, :confirmation_token,   unique: true
    # add_index :clients, :unlock_token,         unique: true
  end
end
