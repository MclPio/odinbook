class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_pararms)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_pararms
    params.require(:user).permit(:bio,:username)
  end

  def authorize_user!
    current_user.id == params[:id]
  end
end
