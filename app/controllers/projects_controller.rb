class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, except: [:index, :show]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    if params[:q]
      session[:q] = params[:q]
      @projects = Project.search(session[:q]).order(:updated_at).page params[:page]
    elsif params[:all] == "all"
      @projects = Project.order(:updated_at).page params[:page]
    elsif params[:all] == "user"
      @projects = Project.where(user_id: current_user.id).order(:updated_at).page params[:page]
    else
      @projects = Project.order(:updated_at).page params[:page]
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.user_id = current_user.id
    if @project.save
      redirect_to project_path(@project)
      flash[:notice] = "Project created successfully!"
    else
      render :new
      flash[:notice] = "Project creation unsuccessful, please see errors."
    end
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to project_path(@project), notice: "Project updated successfully!"
    else
      render :edit
      flash[:alert] = "Project update unsuccessful, please see errors below."
    end
  end

  def show
    @task = Task.new
    @discussion = Discussion.new
  end

  def destroy
    @project.destroy
    redirect_to projects_path
    flash[:alert] = "Project deleted successfully!"
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :due_date)
  end

  def find_project
    @project = Project.find params[:id]
  end

  def authorize_user
    unless can? :manage, @project
      redirect_to root_path, alert: "access denied!"
    end
  end
end
