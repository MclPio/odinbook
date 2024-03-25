class UsersController < ApplicationController
  before_action :authorize_user!, only: [:edit, :update]
  before_action :authenticate_user!

  def index
    @users = User.all

    begin
      @pagy, @users = pagy_countless(@users)
    rescue Pagy::OverflowError
      flash[:alert] = "Invalid page number."
      redirect_to users_path
    end
    if params[:search]
      @users = User.where("username LIKE ?", User.sanitize_sql_like(params[:search]) + "%")
    end
  end

  def show
    @user = User.find(params[:id])
    #Need to handle Couldn't find User with 'id'=88

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_pararms)
      redirect_to @user
    else
      flash.now[:notice] = @user.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_pararms
    params.require(:user).permit(:bio,:username, :avatar_url, :search)
  end

  def authorize_user!
    @user = User.find(params[:id])

    unless current_user == @user
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
