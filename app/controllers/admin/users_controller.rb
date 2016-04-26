class Admin::UsersController < ApplicationController

  before_filter :require_admin

  def index
    @users = User.all
  end

  private

  def require_admin
    redirect_to(root_path) unless current_user && current_user.admin?
  end

end
