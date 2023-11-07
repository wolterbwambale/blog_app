require 'rails_helper'

RSpec.describe 'user index view page', type: :system do
  let!(:user1) do
    User.create(
      name: 'test user1',
      photo: 'https://images3.alphacoders.com/103/thumbbig-1035390.webp',
      bio: 'test_bio1',
      posts_counter: 1
    )
  end

  let!(:user2) do
    User.create(
      name: 'test user2',
      photo: 'https://images3.alphacoders.com/821/thumbbig-821251.webp',
      bio: 'test_bio2',
      posts_counter: 2
    )
  end

  let!(:user3) do
    User.create(
      name: 'test user3',
      photo: 'https://images4.alphacoders.com/979/thumbbig-979282.webp',
      bio: 'test_bio3',
      posts_counter: 0
    )
  end

  describe 'users page' do
    before(:example) do
      visit users_path
    end

    it 'can see all users names' do
      expect(page).to have_content('test user1')
      expect(page).to have_content('test user2')
      expect(page).to have_content('test user3')
    end

    it 'can see profile pictures' do
      image_urls = [
        'https://images3.alphacoders.com/103/thumbbig-1035390.webp',
        'https://images4.alphacoders.com/979/thumbbig-979282.webp',
        'https://images3.alphacoders.com/821/thumbbig-821251.webp'
      ]
      image_urls.each do |url|
        expect(page).to have_selector("img[src*='#{url}']", visible: :all)
      end
    end

    it 'can see posts count' do
      expect(page).to have_selector('li', count: 3) # There are 3 users
      within('li', text: 'test user1') do
        expect(page).to have_content('1', count: 1)
      end
      within('li', text: 'test user2') do
        expect(page).to have_content('2', count: 1)
      end
      within('li', text: 'test user3') do
        expect(page).to have_content('0', count: 1)
      end
    end
  end
end