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

  scenario 'users can view each digg article description', js: true do
    VCR.use_cassette('/news_feeds/digg/features/top_stories') do
      visit '/'
      expect(page).to_not have_content "Tata. Honolulu. Stanley. Those are, respectively, Barack Obama's first pet, city of birth and the first name of his maternal grandfather. I found all three facts with five minutes of Googling."
      page.find('.story', match: :first).hover
      expect(page).to have_content "Tata. Honolulu. Stanley. Those are, respectively, Barack Obama's first pet, city of birth and the first name of his maternal grandfather. I found all three facts with five minutes of Googling."
      page.find('.logo', match: :first).hover
      expect(page).to_not have_content "Tata. Honolulu. Stanley. Those are, respectively, Barack Obama's first pet, city of birth and the first name of his maternal grandfather. I found all three facts with five minutes of Googling."
    end
  end
end