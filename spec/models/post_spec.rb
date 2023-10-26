# spec/models/post_spec.rb

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John', photo: 'https://example.com/john.jpg', bio: 'Test bio', posts_counter: 0) }

  it 'is valid with valid attributes' do
    post = described_class.new(
      author: user,
      title: 'Sample Title',
      comments_counter: 0,
      likes_counter: 0
    )
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post = described_class.new(
      author: user,
      title: nil,
      comments_counter: 0,
      likes_counter: 0
    )
    expect(post).not_to be_valid
  end

  it 'is not valid if title length is greater than 250' do
    post = described_class.new(
      author: user,
      title: 'A' * 251,
      comments_counter: 0,
      likes_counter: 0
    )
    expect(post).not_to be_valid
  end

  it 'is not valid if comments_counter is not an integer' do
    post = described_class.new(
      author: user,
      title: 'Sample Title',
      comments_counter: 2.5,
      likes_counter: 0
    )
    expect(post).not_to be_valid
  end

  it 'is not valid if comments_counter is negative' do
    post = described_class.new(
      author: user,
      title: 'Sample Title',
      comments_counter: -1,
      likes_counter: 0
    )
    expect(post).not_to be_valid
  end

  it 'is not valid if likes_counter is negative' do
    post = described_class.new(
      author: user,
      title: 'Sample Title',
      comments_counter: 0,
      likes_counter: -1
    )
    expect(post).not_to be_valid
  end

  it 'associates with the author (User)' do
    association = described_class.reflect_on_association(:author)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'has many comments' do
    association = described_class.reflect_on_association(:comments)
    expect(association.macro).to eq(:has_many)
  end

  it 'has many likes' do
    association = described_class.reflect_on_association(:likes)
    expect(association.macro).to eq(:has_many)
  end

  it 'increments the user post_counter after saving' do
    described_class.create(
      author: user,
      title: 'Sample Title',
      comments_counter: 0,
      likes_counter: 0
    )

    user.reload

    expect(user.posts_counter).to eq(1)
  end
end
