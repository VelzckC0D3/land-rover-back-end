class Car < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :name, presence: true, length: { maximum: 100 }
  validates :price, presence: true
end
