require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) do
    User.create(
      name: 'test user',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'test_bio',
      posts_counter: 1
    )
  end

  context 'GET /index' do
    before { get '/users' }

    it 'displays a list of users' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('index')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('Here is a list of user')
    end
  end

  context 'GET /show' do
    before { get "/users/#{user.id}" }

    it 'displays the user details for a given post' do
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      expect(response).to render_template('show')
    end

    it 'includes correct placeholder text in the response body' do
      expect(response.body).to include('list of user')
    end
  end
end
