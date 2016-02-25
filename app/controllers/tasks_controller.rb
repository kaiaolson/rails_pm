class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @project = Project.find params[:project_id]
    @task = Task.new task_params
    @task.user = current_user
    @task.project_id = @project.id
    if @task.save
      redirect_to project_path(@project), notice: "Task created!"
    else
      render "/projects/show", alert: "Task not created!"
    end
  end

  def show
  end

  def index
    @tasks = Task.page params[:page]
  end

  def edit
  end

  def update
    @project = Project.find params[:project_id]
    current_status = @task.status
    if @task.update(status: !@task.status)
      TasksMailer.notify_task_owner(@task, current_user).deliver_later unless current_status
      flash[:notice] = "Task updated successfully."
    else
      flash[:alert] = "Task not updated!"
    end
    redirect_to project_path(@project)
  end

  def destroy
    @task.destroy
    redirect_to project_path(params[:project_id]), notice: "Task deleted!"
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_date)
  end

  def find_task
    @task = Task.find params[:id]
  end

end
