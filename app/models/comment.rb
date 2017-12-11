class Comment < ApplicationRecord
  belongs_to :user
  has_one :mechanic

  validates :content, presence: true, length: { maximum: 255 }
  validates :car, presence: true, length: { maximum: 100 }
  validates :cost, presence: true, length: { minimum: 24 }
  validates :rating_general, presence: true, length: { minimum: 5 }
  validates :rating_cost, presence: true, length: { minimum: 5 }
  validates :rating_time, presence: true, length: { minimum: 5 }
end
