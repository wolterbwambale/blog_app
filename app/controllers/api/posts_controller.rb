class Api::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    if params[:author_id].present?
      user = User.find(params[:author_id])
      @posts = user.posts
    else
      @posts = Post.all
    end

    render json: @posts
  end
end
