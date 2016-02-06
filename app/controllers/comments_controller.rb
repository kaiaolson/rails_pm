class CommentsController < ApplicationController
  before_action :find_comment, only: [:show, :edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    if @comment.save
      redirect_to comment_path(@comment), notice: "Comment created successfully!"
    else
      render :new, notice: "Comment not created!"
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
      redirect_to comment_path(@comment), notice: "Comment updated successfully."
    else
      render :edit, notice: "Comment not updated!"
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_path
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
