class FollowsController < ApplicationController
  before_action :authenticate_user!

  def new
    @follow = Follow.new
  end

  def create
    @follow = Follow.new(follow_params)

    if @follow.save
      redirect_to root_path # need to change this later
    else
      render :new, status: :unprocessable_entity
    end
  end

  # toggle! method works great for the approved parameter
  # todo:
  # need validation for duplicate requests
  # write some model tests
  # implement views for accepting/denying requests.
  private

  def follow_params
    params.require(:follow).permit(:follower_id, :followee_id)
  end
end
