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
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_path(@project), notice: "Task created!" }
        format.js   { render :create_success }
      else
        format.html { render "/projects/show", alert: "Task not created!" }
        format.js   { render :create_failure }
      end
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
    respond_to do |format|
      if @task.update(status: !@task.status)
        format.html { # TasksMailer.notify_task_owner(@task, current_user).deliver_later unless current_status
                      flash[:notice] = "Task updated successfully."
                      redirect_to project_path(@project) }
        format.js   { render :update_success }
      else
        format.html { flash[:alert] = "Task not updated!"
                      redirect_to project_path(@project) }
        format.js   { render :update_failure }
      end
    end

  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(params[:project_id]), notice: "Task deleted!" }
      format.js   { render }
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_date)
  end

  def find_task
    @task = Task.find params[:id]
  end

end
