class MembershipsController < ApplicationController
  before_action :authenticate_user

  def create
    project = Project.friendly.find(params[:project_id])
    membership = Membership.new(project: project, user: current_user)
    if membership.save
      redirect_to projects_path, notice: "You're now a member of #{project.title}!"
    else
      redirect_to projects_path, alert: "Unable to join #{project.title}!"
    end
  end

  def destroy
    membership = current_user.memberships.find params[:id]
    membership.destroy
    redirect_to projects_path, notice: "You have removed your membership!"
  end
end
