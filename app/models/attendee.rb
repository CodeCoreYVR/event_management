class Attendee < ActiveRecord::Base
  has_many :categorizations, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances
  has_many :categories, through: :categorizations

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  scope :future_attendees, -> { where('id in (?)', Attendance.future_attendances.pluck(:attendee_id)) }

  def confirmed_events
    Event.joins(:attendances).where("attendances.id in (?) AND events.created_at > ?", seat_ownerships.ids, (Time.now - 1.month))
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
