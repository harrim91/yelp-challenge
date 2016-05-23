class Restaurant < ActiveRecord::Base
  validates :name, :rating, presence: true
end
