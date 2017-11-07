class User < ApplicationRecord
  has_secure_password
  has_many :drinks, dependent: :destroy

  validates :email, :username, :password, presence: true
  validates :email, uniqueness: true
end