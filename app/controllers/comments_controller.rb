class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[ edit update destroy ]
  before_action :set_comment, only: %i[ edit update destroy ]

  def index
    parent_comment = Comment.find(params[:parent_id])
    @child_comments = parent_comment.comments.includes([:user, :post]).order(id: :desc)
    @pagy, @child_comments = pagy_countless(@child_comments, items: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @comment.post, notice: "Comment was successfully created."}
        format.turbo_stream { flash.now[:notice] = "Comment was successfully created." }
      end
    else
      respond_to do |format|
        format.html do
          redirect_to @comment.post, notice: @comment.errors.full_messages.to_sentence,
                                     status: :unprocessable_entity
        end
        format.turbo_stream do
          flash.now[:notice] = @comment.errors.full_messages.to_sentence
          render turbo_stream: turbo_stream.append(:flash, partial: "layouts/flash")
        end
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
      format.html { redirect_to @comment.post, notice: "Comment was successfully deleted."}
      format.turbo_stream { flash.now[:notice] = "Comment was successfully deleted." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :parent_id, :depth, :id).merge(post_id: params[:post_id])
    end

    def authorize_user!
      @comment = Comment.find(params[:id])

      unless current_user == @comment.user
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to root_path
      end
    end
end
