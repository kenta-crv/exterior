class Contract < ApplicationRecord
    has_many :advances, dependent: :destroy
    has_one :client
end
