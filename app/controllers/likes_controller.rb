class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    @like = Like.new
  end

  def create
    @post = Post.find(params[:like][:post_id])
    @like = @post.likes.new(user: current_user)

    if @like.save
      redirect_to @post, notice: "Post was successfully liked."
    else
      render @post, status: :unprocessable_entity
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy

    redirect_to @post, status: :see_other
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
