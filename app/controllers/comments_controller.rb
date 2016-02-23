class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @discussion = Discussion.find params[:discussion_id]
    @comment = Comment.new comment_params
    @comment.discussion = @discussion
    @comment.user = current_user
    if @comment.save
      CommentsMailer.notify_discussion_owner(@comment).deliver_now
      redirect_to discussion_path(@discussion), notice: "Comment created!"
    else
      render "/discussions/show", alert: "Comment not created!"
    end
  end

  def show
  end

  def index
    @comments = Comment.all
  end

  def edit
  end

  def update
    if @comment.update comment_params
      redirect_to discussion_path(@comment.discussion_id), notice: "Comment updated successfully."
    else
      render :edit, notice: "Comment not updated!"
    end
  end

  def destroy
    @discussion = Discussion.find params[:discussion_id]
    @comment.destroy
    redirect_to discussion_path(@discussion)
    flash[:alert] = "Comment deleted!"
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @comment = Comment.find params[:id]
  end
end
