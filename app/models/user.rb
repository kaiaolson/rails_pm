class User < ActiveRecord::Base
  before_create :generate_api_key

  has_many :projects, dependent: :nullify
  has_many :comments, dependent: :nullify
  has_many :discussions, dependent: :nullify
  has_many :tasks, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :favorite_projects, through: :favorites, source: :project
  has_many :memberships, dependent: :destroy
  has_many :project_memberships, through: :memberships, source: :project

  has_secure_password
  validates :password, length: {minimum: 6}, on: :create
  validates :email, presence: true, uniqueness: true,
            format:  /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
            unless: :from_oauth?

  serialize :github_raw_data, Hash

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.find_github_user(omniauth_data)
    where(provider: "github", uid: omniauth_data["uid"]).first
  end

  def self.create_from_github(github_data)
    name = github_data["info"]["name"].split(" ")
    user = User.create(provider: "github",
    uid: github_data["uid"],
    first_name: name[0],
    last_name: name[1],
    password: SecureRandom.hex(16),
    github_token: github_data["credentials"]["token"],
    github_secret: github_data["credentials"]["secret"],
    github_raw_data: github_data)
  end


  private

  def from_oauth?
    uid.present? && provider.present? && provider == "github"
  end

  def generate_api_key
    self.api_key = SecureRandom.hex(32)
    while User.exists?(api_key: self.api_key)
      self.api_key = SecureRandom.hex(32)
    end
  end
end
