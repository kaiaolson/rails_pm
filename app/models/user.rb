class User < ActiveRecord::Base
  has_many :projects, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :discussions, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project

  has_secure_password
  validates :email, presence: true, uniqueness: true,
           format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def full_name
    "#{first_name} #{last_name}"
  end
end
