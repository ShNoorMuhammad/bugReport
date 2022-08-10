class BugsController < ApplicationController
  before_action :require_user_logged_in
  before_action :require_bug_id, only: [:show]

  authorize_resource

  def new
    @bug = Bug.new
  end

  def create
    @bug = Bug.new(bug_params)
    @bug.user = current_user
    # @bug.project = @project
    @bug.project_id = params[:project_id]
    # binding.pry
    if @bug.save
      flash[:success] = "Bug added Succesfully"
      redirect_to bug_path(@bug)
    else
      flash[:danger] = "Bug not added"
      render "new"
    end
  end

  def edit
    @bug = Bug.find(params[:id])
  end

  def update
    @bug = Bug.find(params[:id])
    # binding.pry
    if @bug.update(bug_params)
      flash[:success] = "Updated Sucesfully"
      redirect_to bug_path(@bug)
    else
      flash[:danger] = "Bug Updation failed"
      render "edit"
    end
  end

  def show
    # @project = Project.find(params[:project_id])
    @bug = Bug.find(params[:id])
    project = Project.find(params[:project_id])
    projectBugs = project.bugs
    ids = projectBugs.ids

    if !ids.include?(params[:id].to_i)
      # binding.pry
      flash[:danger] =  "You can Only Access this project Bugs"
      redirect_to root_path
    end


  end

  def index
    # @bugs = Bug.all
    # binding.pry
    project_id = params[:project_id]
    @project = Project.find(project_id)
    @bugs = @project.bugs
  end

  def destroy
    @bug = Bug.find(params[:id])
    @bug.destroy
    flash[:success] = "Deleted sucessfully"
    redirect_to bugs_path
  end

  private

  def bug_params
    params.require(:bug).permit(:description, :bug_title, :deadline, :status, :bug_type, :image, :project_id)
  end

  def require_user_logged_in
    if !user_signed_in?
      flash[:danger] = "you need to login first to do this action"
      redirect_to root_path
    end
  end

  def require_bug_id
    bugProject = Bug.find(params[:id])
    p_id = bugProject.project_id
    bug_projects = Bug.where(project_id: p_id)
    bug_ids = bug_projects.ids

    # binding.pry
    if !bug_ids.include?(params[:id].to_i)
      flash[:danger] = "You can Only Access Your own bugs Projects"
      redirect_to root_path
    end
  end
end
