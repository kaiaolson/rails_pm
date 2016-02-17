class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  belongs_to :user
  paginates_per 10

  validates :title, presence: true, uniqueness: true, length: {minimum: 10}
  validates_date :due_date, :after => lambda { Date.current }

  def self.search(term)
    where("title || description ILIKE ?","%#{term}%")
  end
end
