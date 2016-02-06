class Project < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true, length: {minimum: 10}
  validates_date :due_date, :after => lambda { Date.current }
end
