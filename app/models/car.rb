class Car < ApplicationRecord
  has_many :reservations

  validates :name, presence: true
  validates :price, presence: true
end
