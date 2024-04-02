class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:destroy, :edit, :update]
  before_action :authorize_user_create!, only: [:create]

  def index
    @follows = current_user.follower_follows

    begin
      @pagy, @follows = pagy_countless(@follows)
    rescue Pagy::OverflowError
      flash[:alert] = "Invalid page number."
      redirect_to follows_path
    end
    if params[:search] && params[:search] != ""
      @follows = current_user.followers
                             .where("username LIKE ?", User.sanitize_sql_like(params[:search]) + "%")
                             .map {|id| Follow.find_by(follower_id: id)}
    end
  end

  def create
    @follow = Follow.new(follow_params).toggle(:approved)

    if @follow.save
      redirect_back fallback_location: root_path
    else
      redirect_back fallback_location: root_path, status: :unprocessable_entity
    end
  end

  def edit # Only for authorized user
    @follow = Follow.find(params[:id])
  end

  def update
    @follow = Follow.find(params[:id]).toggle(:approved)

    if @follow.save
      redirect_to follows_path
    else
      render follows_path, status: :unprocessable_entity
    end
  end

  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy

    redirect_back fallback_location: root_path, status: :see_other
  end

  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id, :id, :approved)
  end

  def authorize_user!
    follow = Follow.find_by(id: params[:id])

    return unless follow

    users_involved = [User.find_by(id: follow.follower_id), User.find_by(id: follow.followee_id)].compact

    unless users_involved.include?(current_user)
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def authorize_user_create!
    follower = User.find_by(id: params[:follow][:follower_id])

    unless current_user == follower
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
