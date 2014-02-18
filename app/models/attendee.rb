class Attendee < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
  has_many :categories, through: :categorizations
  
  validates :name, presence: true 
  validates :email, presence: true
  validates :email, uniqueness: true
 

  def confirmed_events
    Event.joins(:attendances).where("attendances.id in (?)", seat_ownerships.ids)
  end

  def waitlisted_events
    Event.joins(:attendances).where("attendances.id in (?)", wait_listed.ids)
  end

  def seat_ownerships
    self.attendances.with_seats
  end

  def wait_listed
    self.attendances.waiting
  end
end
