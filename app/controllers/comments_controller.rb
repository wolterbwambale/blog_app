class CommentsController <

  def new
    @comment = Comment.new
  end

  def create
    @current = current_user
    @post = Post.find(params[:post_id])
    @new_comment = @post.comments.build(comment_params)
    @new_comment.user = @current

    respond_to do |format|
      format.html do
        if @new_comment.save
          redirect_to user_post_path(current_user, @post), notice: 'Comment created successfully'
        else
          redirect_to user_post_path(current_user, @post), alert: 'Comment not created successfully'
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.destroy
      decrement_post_comments_counter(post)
      redirect_to post, notice: 'Comment was successfully destroyed.'
    else
      redirect_to post, alert: 'Failed to destroy comment.'
    end
  end
  #   @comment.destroy
  #   redirect_to post_path(@comment.post), notice: 'Comment was successfully destroyed.'
  # end
  # private

  # def comment_params
  #   params.require(:comment).permit(:text, :author_id, :post_id)
  # end
end
