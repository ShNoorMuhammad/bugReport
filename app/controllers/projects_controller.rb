class ProjectsController < ApplicationController
  before_action :require_user_logged_in
  before_action :require_user_manager, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_same_user_project, only: [:edit, :update, :show, :destroy]
  authorize_resource
  

  
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      current_user.projects << @project 
      flash[:success] = "Project added succesfully"
      redirect_to project_path(@project)
    else
      render "new"
    end
  end

  def show
    @project = Project.find(params[:id])
    if @project
      @dev = @project.users.where(usertype: "Developer")
      @qa = @project.users.where(usertype: "QA")
    else
      render "new"
    end
  end

  def index
    user = current_user
    @projects = user.projects    

  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:success] = "Updated Sucesfully"
      redirect_to project_path(@project)
    else
      render "edit"
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:success] = "Deleted sucessfully"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, user_ids: [])
  end

  def require_user_logged_in
    if !user_signed_in?
      flash[:danger] = "you need to login first to do this action"
      redirect_to root_path
    end
  end

  def require_user_manager
    if user_signed_in? and !current_user.usertype ===  "Manager"
      flash[:danger] = "Only Manager can do this"
      redirect_to root_path
    end
  end

  def require_same_user_project
    ids_project = current_user.projects.ids 

    if !ids_project.include?(params[:id].to_i)
      # binding.pry
      flash[:danger] =  "You can Only Access Your own Projects"
      redirect_to root_path
    end
  end


 

end
