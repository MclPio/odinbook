class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to @post, notice: "Post was successfully liked."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end

#TODO
#Implement the view action of liking a post