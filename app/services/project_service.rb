class ProjectService
  def initialize()

  end

  def daily_tasks(project)
    project.tasks.where("created_at >= ?", Time.beginning_of_day)
  end

  def daily_discussions(project)
    project.discussions.where("created_at >= ?", Time.beginning_of_day)
  end

end
