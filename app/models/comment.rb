class Comment < ApplicationRecord
  belongs_to :user
  has_one :mechanic
end
