class ClientComment < ApplicationRecord
  belongs_to :estimate
  belongs_to :client
  has_one_attached :file # ファイル添付がある場合
end
