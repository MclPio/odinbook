class PolyLikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @poly_like = current_user.poly_likes.new(poly_like_params)

    if @poly_like.save
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.turbo_stream
      end
    else
      redirect_back(fallback_location: root_path)
      flash[:notice] = @poly_like.errors.full_messages.to_sentence
    end
  end

  def destroy
    @poly_like = current_user.poly_likes.find(params[:id])
    @poly_like.destroy

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.turbo_stream
    end
  end

  private

  def poly_like_params
    params.require(:poly_like).permit(:likable_id, :likable_type, :user_id)
  end
end
