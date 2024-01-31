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

  def show
  end
  # toggle! method works great for the approved parameter
  # todo:
  # implement views for accepting/denying requests. Followee should be the one to approve deny
  # edit view to accept/deny requests. update action to implement. need custom params to accept approved.
  # index view to show all requests? or all current followers? What about followings?
  # Implement logic in view to not display follow if request already sent
  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id, :id, :approved)
  end
end
