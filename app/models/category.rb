class Category < ActiveRecord::Base
  belongs_to :categorization
  has_many :attendees, through: :categorization
end
