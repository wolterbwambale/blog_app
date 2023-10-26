class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: 'post_id'
  has_many :likes, foreign_key: 'post_id'

  after_save :update_user_post_count

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_user_post_count
    author.increment!(:posts_counter) if author.present?
  end
end
