# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'authenticated user with no repos goes to dashboard and sees no repos' do
    OmniAuth.config.test_mode = true
    stub_omniauth

    user = create(:user)

    visit '/'

    click_on 'Sign In'

    expect(page).to_not have_css('.github')

    VCR.use_cassette('features/user/user_sees_following') do
      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password
      click_on 'Log In'
      visit '/dashboard'
    end

    click_button 'Connect to Github'
    user.reload
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_css('.github')
    expect(page).to have_css('.following')
    expect(page).to have_content('No followings found')
    OmniAuth.config.mock_auth[:github] = nil
  end
end
