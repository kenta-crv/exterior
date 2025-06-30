class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :estimates
  has_one :contract, dependent: :destroy  # ✅ 1対1の関連
  accepts_nested_attributes_for :contract # （※後述のネストフォームを使うなら）

  has_many :client_comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
with_options if: -> { validation_context == :conclusion } do
  (1..7).each do |i|
    validates "agree_#{i}", inclusion: { in: ["同意しました"], message: "に同意してください" }
  end

  validates :agree, inclusion: { in: ["同意しました"], message: "に同意してください" }
end

  # Commentモデルの親になり得るCliient
  def self.related_companies
    where(company: Comment::STATUS_TO_CLIENT.values.flatten).index_by(&:company)
  end

  mount_uploader :logo, ImagesUploader
  mount_uploader :face, ImagesUploader
  mount_uploader :before_1, ImagesUploader
  mount_uploader :after_1, ImagesUploader
  mount_uploader :before_2, ImagesUploader
  mount_uploader :after_2, ImagesUploader
  mount_uploader :before_3, ImagesUploader
  mount_uploader :after_3, ImagesUploader
  mount_uploader :other_1, ImagesUploader
  mount_uploader :other_2, ImagesUploader
  mount_uploader :other_3, ImagesUploader

  validates :company, presence: true
  validates :post_title, presence: true
  validates :representative_name, presence: true
  validates :representative_kana, presence: true
  validates :tel, presence: true
  validates :address, presence: true
  validates :url, presence: true
  validates :area, presence: true
  # 企業の強みは50文字以上
  validates :question_appeal, length: { minimum: 50 }, allow_blank: true
end
