class Category < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :attendees, through: :categorizations
end
