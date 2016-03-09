class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :due_date, :creator, :favorite_count, :members, :creation_date, :updated_date

  has_many :tasks

  def title
    object.title.titleize
  end

  def due_date
    object.due_date.strftime("%Y-%b-%d")
  end

  def favorite_count
    Favorite.where(project_id: object.id).count
  end

  def creation_date
    object.created_at.strftime("%Y-%b-%d")
  end

  def updated_date
    object.updated_at.strftime("%Y-%b-%d")
  end

  def creator
    creator = User.where(id: object.user_id)[0]
    creator.full_name
  end

  def members
    members = object.members.map{|member| "#{member.first_name} #{member.last_name}"}
  end
end
