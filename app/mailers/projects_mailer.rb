class ProjectsMailer < ApplicationMailer

  def send_daily_summary(project, tasks, discussions)
    @user = project.user
    @project = project
    @tasks = tasks
    @discussions = discussions
    mail(to: @user.email, subject: "Daily Project Summary")
  end
end
