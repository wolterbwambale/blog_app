class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', counter_cache: :posts_counter
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates_presence_of :name
  validates_numericality_of :posts_counter, only_integer: true, greater_than_or_equal_to: 0

  # Method to get the 3 most recent posts for a user
  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def admin?
    role == 'admin'
  end
end
