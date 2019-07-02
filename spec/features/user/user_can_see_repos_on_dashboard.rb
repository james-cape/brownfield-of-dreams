# frozen_string_literal: true

require 'rails_helper'

describe 'User' do
  it 'user can sign in' do
    WebMock.disable!

    user = create(:user)

    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password

    click_on 'Log In'

    visit '/dashboard'

    within('.github') do
      expect(page).to have_content("Github")
    end



    # And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
  end
end
