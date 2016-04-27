class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @current_user = User.find(session[:user_id])
    
    if @user.save
      if @current_user.admin
        redirect_to admin_users_path, notice: "#{@user.email} was created successfully!"
      else
        session[:user_id] = @user.id
        redirect_to movies_path 
      end
    else
      render :new
    end

  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

end
