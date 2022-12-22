class UsersController < ApplicationController
  before_action :redirect_to_categories, only: %i[show index]
  before_action :set_user, only: %i[show edit update destroy]

  def splash
    if current_user
      flash[:notice] = "You have already sign in as, #{current_user.name}"
      redirect_to groups_url
    else
      render :splash_page
    end
  end

  def index
    @users = User.all
  end

  def show; end

  private

  def redirect_to_categories
    redirect_to groups_url
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
