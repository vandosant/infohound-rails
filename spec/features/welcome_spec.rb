require 'rails_helper'
require 'capybara/rails'

feature 'Homepage' do
  scenario 'a welcome message is displayed' do
    visit '/'
    expect(page).to have_content 'Welcome!'
  end
end