require 'rails_helper'

RSpec.feature 'Restaurants', type: :feature do

  context 'no restaurants have been added' do

    scenario 'displays message when no restaurants have been added' do
      visit restaurants_path
      expect(page).to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

  end

  context 'adding a restaurant' do

    scenario 'adds a new restaurant' do
      visit restaurants_path
      click_link 'Add Restaurant'
      expect(current_path).to eq new_restaurant_path
      fill_in :Name, with: 'Macey\'s Meatballs'
      fill_in :Description, with: 'That\'s a SPICY meat-a-ball'
      click_button 'Add'
      expect(current_path).to eq '/restaurants'
      within 'table' do
        expect(page).to have_content 'Macey\'s Meatballs'
        expect(page).to have_content 'That\'s a SPICY meat-a-ball'
      end
    end

    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        visit restaurants_path
        click_link 'Add Restaurant'
        fill_in :Name , with: 'aa'
        fill_in :Description, with: 'This is a description'
        click_button 'Add'
        within('section#errors') { expect(page).to have_content 'Error' }
        visit restaurants_path
        expect(page).not_to have_css 'td', text: 'aa'
      end

      scenario 'does not let you submit a restaurant with no description' do
        visit restaurants_path
        click_link 'Add Restaurant'
        fill_in :Name , with: 'Macey\'s Meatballs'
        click_button 'Add'
        within('section#errors') { expect(page).to have_content 'Error' }
        visit restaurants_path
        expect(page).not_to have_css 'td', text: 'Macey\'s Meatballs'
      end
    end

  end

  context 'restaurants have been added' do
    let!(:mms) do
      Restaurant.create name:'Michael\'s Mac Shack',
                        description: 'Cheesin\''
    end

    scenario 'index displays the restaurant' do
      visit restaurants_path
      within 'table' do
        expect(page).to have_content 'Michael\'s Mac Shack'
        expect(page).to have_content 'Cheesin\''
      end
      expect(page).not_to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

    context 'viewing a restaurant' do

      scenario 'lets a user view a restaurant' do
        visit restaurants_path
        within('table') { click_link 'Michael\'s Mac Shack' }
        expect(current_path).to eq restaurant_path(mms)
        within('h1') { expect(page).to have_content 'Michael\'s Mac Shack' }
        within ('p') { expect(page).to have_content 'Cheesin\'' }
      end

    end

    context 'editing a restaurant' do

      scenario 'lets user edit a restaurant' do
        visit restaurant_path(mms)
        click_link 'Edit'
        expect(current_path).to eq edit_restaurant_path(mms)
        fill_in :Name, with: 'Mike\'s Mac Shack'
        fill_in :Description, with: 'Super Cheese'
        click_button 'Update'
        expect(current_path).to eq restaurants_path
        within 'table' do
          expect(page).to have_content 'Mike\'s Mac Shack'
          expect(page).to have_content 'Super Cheese'
        end
      end

    end

    context 'deleting a restaurant' do

      scenario 'lets user delete a restaurant' do
        visit restaurant_path(mms)
        click_link 'Delete'
        expect(current_path).to eq restaurants_path
        expect(page).to have_content 'Restaurant deleted'
        expect(page).to have_content 'No restaurants found'
        expect(page).not_to have_content 'Michael\'s Mac Shack'
      end

    end

    context 'adding a duplicate restaurant' do
      it 'does not let you submit a duplicate name' do
        visit restaurants_path
        click_link 'Add Restaurant'
        fill_in :Name , with: 'Michael\'s Mac Shack'
        fill_in :Description, with: 'This is a description'
        click_button 'Add'
        within('section#errors') { expect(page).to have_content 'Error' }
        visit restaurants_path
        expect(page).to have_css 'td.restaurant_name', text: 'Michael\'s Mac Shack', count: 1
      end
    end

  end

end
