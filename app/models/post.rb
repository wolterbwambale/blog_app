class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, foreign_key: 'post_id',counter_cache: :comments_counter, dependent: :destroy
  has_many :likes

  validates_presence_of :title
  validates_length_of :title, maximum: 250
  validates_numericality_of :comments_counter, only_integer: true, greater_than_or_equal_to: 0
  validates_numericality_of :likes_counter, only_integer: true, greater_than_or_equal_to: 0

  after_save :update_user_post_count

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end

  private

  def update_user_post_count
    author.increment!(:posts_counter) if author.present?
  end
end
