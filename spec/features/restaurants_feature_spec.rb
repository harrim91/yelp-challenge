require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do

    scenario 'displays message when no restaurants have been added' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

  end

  context 'restaurants have been added' do
    before do
      Restaurant.create name:'Michael\'s Mac Shack', rating: 5
    end

    scenario 'displays the restaurant' do
      visit '/restaurants'
      within 'table' do
        expect(page).to have_content 'Michael\'s Mac Shack'
        expect(page).to have_content '5'
      end
      expect(page).not_to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

  end

  context 'adding a restaurant' do

    scenario 'adds a new restaurant' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      expect(current_path).to eq '/restaurants/new'
      fill_in :Name, with: 'Macey\'s Meatballs'
      fill_in :Rating, with: 5
      click_button 'Add'
      expect(current_path).to eq '/restaurants'
      within 'table' do
        expect(page).to have_content 'Macey\'s Meatballs'
        expect(page).to have_content '5'
      end
    end

  end

  context 'viewing a restaurant' do
    let!(:mmc) { Restaurant.create name:'Michael\'s Mac Shack', rating: 5 }

    scenario 'lets a user view an inidividual restaurant' do
      visit '/restaurants'
      within 'table' do
        click_link 'Michael\'s Mac Shack'
      end
      expect(current_path).to eq "/restaurants/#{mmc.id}"
      within 'h1' do
        expect(page).to have_content 'Michael\'s Mac Shack'
      end
      within 'h2' do
        expect(page).to have_content 'Rating: 5'
      end
    end
  end

end
