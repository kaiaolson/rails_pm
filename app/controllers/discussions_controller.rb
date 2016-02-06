class DiscussionsController < ApplicationController
  before_action :find_discussion, only: [:show, :edit, :update, :destroy]

  def index
    @discussions = Discussion.all
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new discussion_params
    if @discussion.save
      redirect_to discussion_path(@discussion), notice: "Discussion created successfully!"
    else
      render :new, notice: "Discussion creation unsuccessful, please see errors below."
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
