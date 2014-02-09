class Attendee < ActiveRecord::Base
  has_many :categorizations
  has_many :attendances
  has_many :events, through: :attendances
  has_many :categories, through: :categorizations

  
  validates :name, presence: true
  validates :email, presence: true

end
