require 'rails_helper'

RSpec.describe Review, type: :model do

  describe '#rating' do
    describe 'validation' do
      it 'cannot have a rating greater than 5' do
        review = Review.new rating: 6
        expect(review).to have(1).error_on :rating
        expect(review).not_to be_valid
      end

      it 'cannot have a rating lower than 1' do
        review = Review.new rating: 0
        expect(review).to have(1).error_on :rating
        expect(review).not_to be_valid
      end
    end
  end

end
