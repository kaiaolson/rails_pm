class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    if @task.save
      redirect_to task_path(@task), notice: "Task created successfully!"
    else
      render :new, notice: "Task not created!"
    end
  end

  def show
  end

  def index
    @tasks = Task.all
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
    redirect_to tasks_path
    flash[:alert] = "Task deleted!"
  end

  private

  def task_params
    params.require(:task).permit(:title, :due_date)
  end

  def find_task
    @task = Task.find params[:id]
  end
end
