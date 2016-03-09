class User < ActiveRecord::Base
  has_many :projects, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :discussions, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project
  has_many :memberships, dependent: :destroy
  has_many :project_memberships, through: :memberships, source: :project

  has_secure_password
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, length: {minimum: 6}, on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  before_create :generate_api_key

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
    while User.exists?(api_key: self.api_key)
      self.api_key = SecureRandom.hex(32)
    end
  end
end
