class DiscussionSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_many :comments

  def title
    object.title.titleize
  end
end
