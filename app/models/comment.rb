class Comment < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  validates :body, presence: true

  def body_snippet
    if body.length < 30
      body
    else
      "#{body.slice(0..26)}..."
    end
  end
end
