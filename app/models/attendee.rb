class Attendee < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
  has_many :categories, through: :categorizations

  
  validates :name, presence: true 
  validates :email, presence: true
  validates :email, uniqueness: true
  
end
