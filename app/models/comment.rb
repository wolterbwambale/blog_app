class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post, class_name: 'Post'

  after_save :update_post_comments_counter
  after_destroy :decrement_post_comments_counter

  private

  def update_post_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comments_counter) if post.present?
  end
end
