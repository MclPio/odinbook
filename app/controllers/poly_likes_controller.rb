class PolyLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @poly_like = current_user.poly_likes.new(poly_like_params)

    if @poly_like.save
      flash[:notice] = @poly_like.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @poly_like = current_user.poly_likes.find(params[:id])
    @poly_like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def poly_like_params
    params.require(:poly_like).permit(:likable_id, :likable_type, :user_id)
  end
end
