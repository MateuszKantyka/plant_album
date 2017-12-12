class Mechanic < ApplicationRecord
  has_many :comments, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 255 }
  validates :city, presence: true, length: { maximum: 48 }
  validates :post_code, presence: true, length: { maximum: 48 }
  validates :address, presence: true, length: { maximum: 48 }
  validates :phone_number, presence: true, length: { maximum: 15 }
  validates :description, presence: true, length: { maximum: 255 }
end
