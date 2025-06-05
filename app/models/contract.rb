class Contract < ApplicationRecord
    has_many :advances, dependent: :destroy
    belongs_to :client
end
