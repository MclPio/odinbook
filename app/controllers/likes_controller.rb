# class LikesController < ApplicationController
#   before_action :authenticate_user!

#   def create
#     @like = current_user.likes.new(like_params)
#     if @like.save
#       flash[:notice] = @like.errors.full_messages.to_sentence
#     end

#     redirect_back(fallback_location: root_path)
#   end

#   def destroy
#     @like = current_user.likes.find(params[:id])
#     @like.destroy
#     redirect_back(fallback_location: root_path)
#   end

#   private

#   def like_params
#     params.require(:like).permit(:post_id, :user_id)
#   end
# end
# Would need to convert this to likable controller or 
# something xd xd, wooah, I have to edit the views again to likes posts!!!