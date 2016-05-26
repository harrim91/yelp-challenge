require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  describe '#name' do
    describe 'validation' do
      it 'is not valid with a name of less than three characters' do
        restaurant = Restaurant.new name: 'aa', description: 'desc'
        expect(restaurant).to have(1).error_on :name
        expect(restaurant).not_to be_valid
      end

      it 'is not valid unless it has a unique name' do
        Restaurant.create name:'Michael\'s Meatballs', description: 'desc'
        restaurant = Restaurant.new name: 'Michael\'s Meatballs', description: 'description2'
        expect(restaurant).to have(1).error_on :name
        expect(restaurant).not_to be_valid
      end
    end
  end

  describe '#description' do
    describe 'validation' do
      it 'is not valid without a description' do
        restaurant = Restaurant.new name: 'aa'
        expect(restaurant).to have(1).error_on :description
        expect(restaurant).not_to be_valid
      end
    end
  end

end
