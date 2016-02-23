class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  belongs_to :user
  paginates_per 10

  validates :title, presence: true, uniqueness: true, length: {minimum: 10}
  validates_date :due_date, :after => lambda { Date.current }

  def self.search(term)
    where("title || description ILIKE ?","%#{term}%")
  end

  def self.filter_by_due_date(date)
    where("due_date > #{date}")
  end

  def self.filter_by_email(email)
    user = User.find_by_email(email)
  end

  def favorite_for(user)
    favorites.find_by_user_id user
  end
end
