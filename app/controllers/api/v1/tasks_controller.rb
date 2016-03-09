class Api::V1::TasksController < Api::BaseController

  def create
    task_params = params.require(:task).permit(:title, :due_date, :status)
    @project = Project.friendly.find params[:project_id]

    @task = Task.new task_params
    @task.user = @user
    @task.project = @project
    if @task.save
      head :ok
    else
      render json: {errors: @task.errors.full_messages }
    end
  end

end
