class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    @like = Like.new(author_id: current_user.id, post_id: @post.id)
    @like.update_post_likes_counter
    redirect_to user_post_path(@post), notice: 'Post liked successfully.'

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

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
