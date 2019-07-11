# frozen_string_literal: true

require 'rails_helper'

describe 'User logs in with Github' do
  it 'then invites user with public email' do
    VCR.use_cassette('features/user/user_sends_an_invite') do
      user = create(:user, active: true, github_token: ENV['GITHUB_TOKEN_M'])

      visit '/'

      click_on 'Sign In'

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      user.reload
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_button("Send Invite")
      click_button "Send Invite"
      expect(current_path).to eq(invite_path)

      fill_in 'invitee_github_handle', with: "whomer"

      click_button "Send Invite"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Successfully sent invite!")

      # Invitee receives email with link to click on
      visit 'http://localhost:3000/register'
      expect(current_path).to eq(register_path)
    end
  end

  it 'then invites user with no public email' do
    VCR.use_cassette('features/user/user_invites_non-public_email') do
      user = create(:user, active: true, github_token: ENV['GITHUB_TOKEN_M'])

      visit '/'

      click_on 'Sign In'

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      visit '/dashboard'

      user.reload
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_button("Send Invite")
      click_button "Send Invite"
      expect(current_path).to eq(invite_path)

      fill_in 'invitee_github_handle', with: "not-a-real-user-23452222"

      click_button "Send Invite"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")

      # Invitee receives email with link to click on
      visit 'http://localhost:3000/register'
      expect(current_path).to eq(register_path)
    end
  end
end
