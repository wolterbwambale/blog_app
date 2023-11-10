class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts if @user
    @posts = Post.paginate(page: params[:page], per_page: 2)
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
    cookies[:post_id] = @post.id if @post.present?
    nil unless @post.nil?
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params.merge(author_id: @user.id))
    if @post.save

      @post.update_posts_count

      redirect_to user_posts_path(@user), notice: 'Post created successfully.'
    else
      @posts = @user.posts
      render :index
    end
  end

  def destroy
    current_user = User.find(params[:author_id])
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy
    @post.decrement_posts_count
    redirect_to user_posts_path(current_user), notice: 'Post deleted successfully.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id, :comments_counter, :likes_counter)
  end
end
