require 'rails_helper'

RSpec.describe 'user show view page', type: :system do
  let!(:user1) do
    User.create(
      name: 'test user1',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'test_bio1'
    )
  end

  let!(:posts) do
    [
      Post.create(
        author: user1, # Set the author of the post to user1
        title: 'Post 1',
        text: 'Post 1 content',
        comments_counter: 1,
        likes_counter: 1
      ),
      Post.create(
        author: user1, # Set the author of the post to user1
        title: 'Post 2',
        text: 'Post 2 content',
        comments_counter: 2,
        likes_counter: 2
      ),
      Post.create(
        author: user1, # Set the author of the post to user1
        title: 'Post 3',
        text: 'Post 3 content',
        comments_counter: 3,
        likes_counter: 3
      )
    ]
  end

  describe 'show user and post details' do
    before(:example) do
      visit user_path(user1)
    end

    it 'displays user information' do
      expect(page).to have_content(user1.name)
      expect(page).to have_content(user1.bio)
      expect(page).to have_selector("img[src='#{user1.photo}']")
    end

    it 'goes to post show page when clicking a post' do
      post_element = find('.list-group-item', match: :first)
      post_id = posts.first.id
      user_id = user1.id
      visit user_post_path(user_id, post_id)
      post_element.click
      expect(page).to have_current_path(user_post_path(user_id, post_id))
    end

    it 'redirects to user\'s posts index page when clicking to see all posts' do
      visit user_path(user1)

      click_link 'See all posts'

      expect(page).to have_current_path(user_posts_path(user1))
    end
  end
end
