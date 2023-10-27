class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  # Method to update the likes counter for a post
  after_save :update_post_like_counter

  private

  def update_post_like_counter
    post.increment!(:likes_counter)
  end
end
