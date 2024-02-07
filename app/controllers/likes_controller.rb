class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)

    if @like.save
      flash[:notice] = @like.errors.full_messages.to_sentence
    end

    redirect_to @like.post
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    post = @like.post
    @like.destroy
    redirect_to post
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :user_id)
  end
end
