class Car < ApplicationRecord
  has_many :reservations

  validates :name, presence: true, length: { maximum: 100 }
  validates :model, presence: true
  validates :year, presence: true
  validates :price, presence: true
  validates :main_image, presence: true
  validates :side_image, presence: true
end
