class TasksMailer < ApplicationMailer

  def notify_task_owner(task, user)
    @user = task.user
    @task = task
    @second_user = user
    mail(to: @user.email, subject: "#{@second_user.full_name} has completed #{@task.title}")
  end
end
