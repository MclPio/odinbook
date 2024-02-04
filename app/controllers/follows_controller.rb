class FollowsController < ApplicationController
  before_action :authenticate_user!
  def index
    @follows = current_user.follower_follows
  end

  def new
    @follow = Follow.new
  end

  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      redirect_to users_path
    else
      redirect_to users_path, status: :unprocessable_entity
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

    redirect_to follows_path, status: :see_other 
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
