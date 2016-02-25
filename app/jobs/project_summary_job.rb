class ProjectSummaryJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Project.all.each do |project|
      @tasks = project.tasks.where("created_at >= ?", Time.zone.now.beginning_of_day)
      @discussions = project.discussions.where("created_at >= ?", Time.zone.now.beginning_of_day)
      ProjectsMailer.send_daily_summary(project, @tasks, @discussions).deliver_now
    end
  end
end
