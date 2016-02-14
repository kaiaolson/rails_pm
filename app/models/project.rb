class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :discussions, dependent: :destroy
  paginates_per 10

  validates :title, presence: true, uniqueness: true, length: {minimum: 10}
  validates_date :due_date, :after => lambda { Date.current }


end
