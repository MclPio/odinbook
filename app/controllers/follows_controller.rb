class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @follows = current_user.follower_follows

    begin
      @pagy, @follows = pagy_countless(@follows)
    rescue Pagy::OverflowError
      flash[:alert] = "Invalid page number."
      redirect_to follows_path
    end
    if params[:search]
      @follows = current_user.followers
                             .where("username LIKE ?", User.sanitize_sql_like(params[:search]) + "%")
                             .map {|id| Follow.find_by(follower_id: id)}
    end
  end

  def new
    @follow = Follow.new
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

  def show
  end
  # toggle! method works great for the approved parameter
  # todo:
  # Change approved param to status, which can only have 3 values: accepted, pending, ignored
  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id, :id, :approved)
  end
end
