class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @project = Project.find params[:project_id]
    task_params = params.require(:task).permit(:title, :due_date)
    @task = Task.new task_params
    @task.project_id = @project.id
    if @task.save
      redirect_to project_path(@project), notice: "Task created!"
    else
      render "/projects/show", alert: "Task not created!"
    end
  end

  def show
    flip_status if params[:flip]
    redirect_to project_path(params[:project_id])
  end

  def index
    @tasks = Task.page params[:page]
  end

  def edit
  end

  def update
    if @task.update task_params
      redirect_to task_path(@task), notice: "Task updated successfully."
    else
      render :edit, notice: "Task not updated!"
    end
  end

  def destroy
    @task.destroy
    redirect_to post_path(params[:post_id]), notice: "Task deleted!"
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_date, :status)
  end

  def find_task
    @task = Task.find params[:id]
  end

  def flip_status
    find_task
    if @task.status == "Not Done"
      @task.status = "Done"
      @task.save
    else
      @task.status = "Not Done"
      @task.save
    end
  end
end
