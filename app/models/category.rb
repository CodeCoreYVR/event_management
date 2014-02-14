class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :attendees, through: :categorizations
end
