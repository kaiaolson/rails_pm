class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.page params[:page]
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
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
end
