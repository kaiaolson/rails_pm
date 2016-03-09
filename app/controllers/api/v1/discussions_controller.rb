class Api::V1::DiscussionsController < Api::BaseController
  before_action :find_project, only: [:index, :show]

  def index
    @discussions = @project.discussions
    render json: @discussions
  end

  def show
    @discussion = @project.discussions.find params[:id]
    render json: @discussion
  end

  private

  def find_project
    @project = Project.friendly.find params[:project_id]
  end
end
