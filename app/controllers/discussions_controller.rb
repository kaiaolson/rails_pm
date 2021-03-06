class DiscussionsController < ApplicationController
  before_action :find_discussion, only: [:show, :edit, :update, :destroy]

  def index
    @discussions = Discussion.all
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @project = Project.friendly.find params[:project_id]
    discussion_params = params.require(:discussion).permit(:title, :description)
    @discussion = Discussion.new discussion_params
    @discussion.project = @project
    @discussion.user = current_user
    if @discussion.save
      redirect_to project_path(@project), notice: "Discussion created successfully!"
    else
      render "/projects/show", notice: "Discussion creation unsuccessful, please see errors below."
    end
  end

  def edit
  end

  def update
    if @discussion.update discussion_params
      redirect_to discussion_path(@discussion), notice: "Discussion updated successfully!"
    else
      render :edit, notice: "Discussion update unsuccessful, please see errors below."
    end
  end

  def show
    @comment = Comment.new
  end

  def destroy
    @discussion.destroy
    redirect_to discussions_path
    flash[:alert] = "Discussion deleted successfully!"
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

  def find_discussion
    @discussion = Discussion.find params[:id]
  end
end
