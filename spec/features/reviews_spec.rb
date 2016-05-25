require 'rails_helper'

RSpec.feature 'Reviews', type: :feature do
  let!(:mms) do
      Restaurant.create name:'Michael\'s Mac Shack',
                        description: 'Cheesin\''
  end

  scenario 'allows users to leave a review' do
    visit restaurant_path(mms)
    fill_in :Rating, with: '5'
    fill_in :Comment, with: 'I can\'t move'
    click_button 'Leave Review'

    expect(current_path).to eq restaurant_path(mms)
    within 'table#reviews' do
      expect(page).to have_content 'I can\'t move'
      expect(page).to have_content '5'
    end
  end
end
