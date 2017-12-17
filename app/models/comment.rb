class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :mechanic

  validates :content, presence: true, length: { maximum: 255 }
  validates :car, presence: true, length: { maximum: 100 }
  validates :cost, presence: true, length: { maximum: 24 }
  validates :rating_general, presence: true, inclusion: 1..5
  validates :rating_cost, presence: true, inclusion: 1..5
  validates :rating_time, presence: true, inclusion: 1..5
end
