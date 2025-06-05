class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :estimates
  has_one :contract, dependent: :destroy  # ✅ 1対1の関連
  accepts_nested_attributes_for :contract # （※後述のネストフォームを使うなら）

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Commentモデルの親になり得るCliient
  def self.related_companies
    where(company: Comment::STATUS_TO_CLIENT.values.flatten).index_by(&:company)
  end

end
