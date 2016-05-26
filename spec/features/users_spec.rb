require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  context 'user not signed in' do
    it 'should see correct links' do
      visit root_path
      within 'header' do
        expect(page).to have_link 'Sign In'
        expect(page).to have_link 'Sign Up'
        expect(page).not_to have_link 'Sign Out'
      end
    end
  end

  context 'user signed in' do
    before do
      visit root_path
      click_link 'Sign Up'
      fill_in :Email, with: 'test@example.com'
      fill_in :Password, with: 'testtest'
      fill_in :'Password confirmation', with: 'testtest'
      click_button 'Sign up'
    end

    it 'should see correct links' do
      visit root_path
      within 'header' do
        expect(page).not_to have_link 'Sign In'
        expect(page).not_to have_link 'Sign Up'
        expect(page).to have_link 'Sign Out'
      end
    end
  end

end
