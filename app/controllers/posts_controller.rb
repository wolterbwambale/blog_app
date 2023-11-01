class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
    @posts = @user.posts if @user
    @posts = Post.paginate(page: params[:page], per_page: 2)
  end

  def show
    @post = Post.find(params[:id])
  end
end
