class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  paginates_per 10

  validates :title, presence: true, uniqueness: {scope: :project_id}
  validates :due_date, presence: true

  def status_string
    status ? "Done" : "Not Done"
  end
end
