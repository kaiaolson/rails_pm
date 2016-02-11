class Task < ActiveRecord::Base
  belongs_to :project
  paginates_per 10

  validates :title, presence: true, uniqueness: {scope: :project_id}
end
