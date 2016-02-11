class Discussion < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :project
  
  validates :title, presence: true, uniqueness: true
end
