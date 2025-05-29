class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :estimates
  belongs_to :contract
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Commentモデルの親になり得るCliient
  def self.related_companies
    where(company: Comment::STATUS_TO_CLIENT.values.flatten).index_by(&:company)
  end

end
