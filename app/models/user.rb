class User < ApplicationRecord
  before_save :downcase_email
  has_secure_password
  has_many :comments, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum: 8 }

  private

  def downcase_email
    email.downcase!
  end
end
