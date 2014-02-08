class Attendee < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations

  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
end
