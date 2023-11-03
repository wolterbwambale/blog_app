class LikesController < ApplicationController
  def create
    @current = current_user
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user_id: @current.id)

    puts @current.id
    puts @post.id

    respond_to do |format|
      format.html do
        if @like.save
          redirect_to user_post_path(@current, @post), notice: 'You liked the post.'
        else
          redirect_to user_post_path(@current, @post), alert: 'Unable to like the post.'
        end
      end
    end
  end
end
