class FavoritesController < ApplicationController
  before_action :authenticate_user

  def index
    @projects = current_user.favorite_projects.page params[:page]
  end

  def create
    project = Project.friendly.find params[:project_id]
    favorite = Favorite.new(project: project, user: current_user)
    if favorite.save
      redirect_to project, notice: "Project added to favorites!"
    else
      redirect_to project, alert: "Project already in favorites!"
    end
  end

  def destroy
    project = Project.friendly.find params[:project_id]
    favorite = current_user.favorites.find params[:id]
    favorite.destroy
    redirect_to project, notice: "Project removed from favorites."
  end
end
