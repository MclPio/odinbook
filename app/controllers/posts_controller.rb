class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authorize_user!, only: %i[ edit update destroy ]
  # GET /posts or /posts.json
  def index
    @post = Post.new
    approved_follows = current_user.followee_follows.where(approved: true)
    followee_ids = approved_follows.pluck(:followee_id)
    @posts = Post.includes(:user)
                 .where(user_id: followee_ids << current_user.id)
                 .order(created_at: :desc)

    @pagy, @posts = pagy_countless(@posts, items: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post_comments = @post.comments.where(parent_id: nil).includes([:user]).order(id: :desc)

    @pagy, @post_comments = pagy_countless(@post_comments, items: 10)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        #modified to align with create form on index view
        format.html { redirect_to posts_url, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find_by(id: params[:id])

    unless @post
      flash[:alert] = 'Post not found.'
      redirect_to root_path
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:body, :user_id)
  end

  def authorize_user!
    unless current_user.id == @post.user_id
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end
end
