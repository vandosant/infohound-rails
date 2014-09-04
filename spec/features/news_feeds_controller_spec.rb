require 'rails_helper'
require 'capybara/rails'

feature 'news aggregation' do
  scenario 'users can view top articles from digg' do
    VCR.use_cassette('/news_feeds/digg/features/top_stories') do
      visit '/'
      expect(page).to have_content 'Digg'
      expect(page).to have_link "It's Time To Kill The Online Security Question"
    end
  end
end