class Mechanic < ApplicationRecord
  has_many :comments

  validates :name, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 48 }
  validates :post_code, presence: true, length: { minimum: 48 }
  validates :address, presence: true, length: { minimum: 48 }
  validates :rating, presence: true, length: { minimum: 5 }
  validates :phone_number, presence: true, length: { minimum: 15 }
  validates :description, presence: true, length: { maximum: 255 }
end
