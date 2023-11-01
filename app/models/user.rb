class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates_presence_of :name
  validates_numericality_of :posts_counter, only_integer: true, greater_than_or_equal_to: 0

  # Method to get the 3 most recent posts for a user
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
