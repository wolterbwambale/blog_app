require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', photo: 'https://example.com/john.jpg', bio: 'User bio', posts_counter: 0) }
  let(:post) { Post.create(author: user, title: 'Sample Post', comments_counter: 0, likes_counter: 0) }
  let(:comment) { Comment.new(author_id: user.id, post_id: post.id) }

  before { user.save! }
  before { post.save! }

  it 'creating a comment should trigger update_post_comment_counter and increment comments_counter' do
    expect(post.comments_counter).to eq(0)

    comment.save!

    post.reload
    expect(post.comments_counter).to eq(1)
  end
end
