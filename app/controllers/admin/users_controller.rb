class Admin::UsersController < ApplicationController

  before_filter :restrict_access, :require_admin

  def index 
   @users = User.order(:lastname).page params[:page]
  end


  private

   def require_admin
    if !current_user.admin?
      flash[:alert] = "You must be an administrator."
      redirect_to(root_path)
    end
  end

end
