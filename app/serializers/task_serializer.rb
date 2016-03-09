class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :due_date, :status

  def title
    object.title.titleize
  end

  def status
    object.status == true ? "Completed" : "Incomplete"
  end
end
