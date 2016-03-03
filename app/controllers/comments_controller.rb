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
    respond_to do |format|
      if @comment.save
        # CommentsMailer.notify_discussion_owner(@comment).deliver_later
        format.html { redirect_to discussion_path(@discussion), notice: "Comment created!" }
        format.js { render :create_success }
      else
        format.html { render "/discussions/show", alert: "Comment not created!" }
        format.js { render :create_failure }
      end
    end
  end

  def show
  end

  def index
    @comments = Comment.all
  end

  def edit
    @discussion = Discussion.find params[:discussion_id]
    respond_to do |format|
      format.js { render :edit_comment } 
    end
  end

  def update
    respond_to do |format|
      if @comment.update comment_params
        format.html { redirect_to discussion_path(@comment.discussion_id), notice: "Comment updated successfully." }
        format.js   { render :update_success }
      else
        format.html { render :edit, notice: "Comment not updated!" }
        format.js   { render :update_failure }
      end
    end
  end

  def destroy
    @discussion = Discussion.find params[:discussion_id]
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to discussion_path(@discussion)
                    flash[:alert] = "Comment deleted!" }
      format.js { render }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_comment
    @comment = Comment.find params[:id]
  end
end
