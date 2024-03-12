class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[ edit update destroy ]
  before_action :set_comment, only: %i[ edit update destroy ]

  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @comment = current_user.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        flash[:notice] = @comment.errors.full_messages.to_sentence
        format.html {render @comment.post, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    if @comment.update(comment_params)
      redirect_to post_url(@comment.post), notice: "Comment was successfully updated."
    else
      flash[:notice] = @comment.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :parent_id, :depth).merge(post_id: params[:post_id])
    end

    def authorize_user!
      @comment = Comment.find(params[:id])

      unless current_user == @comment.user
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to root_path
      end
    end
end
