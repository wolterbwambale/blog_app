require 'rails_helper'

RSpec.describe 'post index view page', type: :system do
  let!(:user1) do
    User.create(
      name: 'test user1',
      photo: 'https://example.com/user1.jpg', # Use a local URL or placeholder
      bio: 'test_bio1',
      posts_counter: 1
    )
  end

  let!(:post1) do
    Post.create(author: user1, title: 'Post 1', text: 'Post 1 content', comments_counter: 1, likes_counter: 0)
  end

  let!(:post2) do
    Post.create(author: user1, title: 'Post 2', text: 'Post 2 content', comments_counter: 1, likes_counter: 0)
  end

  let!(:comment1) do
    Comment.create(post: post1, user: user1, text: 'nice!')
  end

  let!(:comment2) do
    Comment.create(post: post1, user: user1, text: 'great!')
  end

  describe 'show correct posts for user1' do
    before(:example) do
      visit user_posts_path(user1)
    end
    it 'displays the user\'s username' do
      expect(page).to have_content(user1.name)
    end

    it 'displays the user\'s profile picture' do
      expect(page).to have_selector("img[src='#{user1.photo}']")
    end

    it 'displays the number of posts the user has written' do
      expect(page).to have_content("Number of posts: #{user1.posts_counter}")
    end
    it 'displays the first comments on a post' do
      expect(page).to have_content(comment1.text)
    end
    it 'displays a post\'s title and text' do
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post1.text)
      expect(page).to have_content(post2.title)
      expect(page).to have_content(post2.text)
    end

    it 'displays the number of comments a post has' do
      # Visit the user's posts page
      visit user_posts_path(user1)

      expect(page).to have_content(post1.title)
      expect(page).to have_content(post1.text)

      # Check the comments count in the updated format
      expect(page).to have_content("#{post1.comments_counter} Comments")
    end

    it 'displays the number of likes a post has' do
      # Visit the user's posts page
      visit user_posts_path(user1)

      # Check for the post's title and content
      expect(page).to have_content(post1.title)
      expect(page).to have_content(post1.text)

      expect(page).to have_content("#{post1.likes_counter} Likes")
    end

    it 'redirects to the post show page when a post is clicked' do
      click_link post1.title
      expect(page).to have_current_path(user_post_path(user1, post1))
      expect(page).to have_content(post1.title)
    end

    it 'displays a section for pagination if there are more posts' do
      # Set the user's posts_counter to a value that exceeds the page limit
      user1.update(posts_counter: 10)

      visit user_path(user1)
      expect(page).to have_selector('.button-container')
    end
  end
end
