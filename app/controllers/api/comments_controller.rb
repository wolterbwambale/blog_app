class Api::CommentsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, only: [:create]

  def index
    user = User.find(params[:user_id])
    @post = user.posts.find(params[:post_id])

    if @post
      @comments = @post.comments
      render json: @comments
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  def create
    user = User.find(params[:user_id])
    @post = user.posts.find(params[:post_id])

    if @post
      @comment = @post.comments.new(comment_params)
      @comment.user = current_user

      if @comment.save
        render json: @comment, status: :created
      else
        render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Post not found' }, status: :not_found
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
