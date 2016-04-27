class Admin::UsersController < ApplicationController

  before_filter :restrict_access, :require_admin

  def index 
   @users = User.order(:lastname).page params[:page]
  end

  def new
    @user = User.new
  end

  def create
  @user = User.new(user_params)
  
    if @user.save
        redirect_to admin_users_path, notice: "#{@user.email} was created successfully!"
    else
      render :new
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end


  private

  def require_admin
    if !current_user.admin?
      flash[:alert] = "You must be an administrator."
      redirect_to(root_path)
    end
  end

  def user_params
    params.require(:user).permit(
      :email, :firstname, :lastname, :password, :password_confirmation, :admin
      )
  end

end
