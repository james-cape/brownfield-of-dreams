# frozen_string_literal: true

require 'rails_helper'

describe 'Visitor' do
  describe 'on the home page' do
    it 'can see a list of tutorials' do
      tutorial1 = create(:tutorial, classroom: false)
      tutorial2 = create(:tutorial, classroom: true)

      visit root_path

      expect(page).to have_css('.tutorial', count: 1)

      within(first('.tutorials')) do
        expect(page).to have_css('.tutorial')
        expect(page).to have_css('.tutorial-description')
        expect(page).to have_content(tutorial1.title)
        expect(page).to have_content(tutorial1.description)
        expect(page).to_not have_content(tutorial2.title)
        expect(page).to_not have_content(tutorial2.description)
      end
    end
  end
end
