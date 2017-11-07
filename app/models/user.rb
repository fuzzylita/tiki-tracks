class User < ApplicationRecord
  has_secure_password
  has_many :drinks

  validates :email, :username, :password, presence: true
  validates :email, uniqueness: true
end