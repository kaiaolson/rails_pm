class User < ActiveRecord::Base
  has_many :projects, dependent: :nullify
  has_secure_password
  validates :email, presence: true, uniqueness: true,
           format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
end
