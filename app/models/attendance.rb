class Attendance < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :event
  validate :cap_check
  validates_uniqueness_of :attendee_id, :scope => :event_id

  def cap_check
    event_seats_taken=event.attendances.length
    if (event.seats <= event_seats_taken)
      errors.add(:event_id," #{event.title} has been filled. Sorry!" )
    end
  end

end
