class Attendance < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :event
  validates_uniqueness_of :attendee_id, :scope => :event_id

  before_create :waitlist_check
  after_destroy :update_event_waitlist

  #validate :cap_check
  # def cap_check
  #   event_seats_taken=event.attendances.length
  #   if (event.seats <= event_seats_taken)
  #     errors.add(:event_id," #{event.title} has been filled. Sorry!" )
  #   end
  # end

  scope :with_seats, -> {where("NOT waitlisted or waitlisted is NULL")}

  scope :waiting, -> {where("waitlisted").order('created_at ASC')}
  scope :future_attendances, -> { joins(:event).merge(Event.future_events) }

  def waitlist_check
    event_seats_taken ||= self.event.seat_ownerships.length
    event_all_seats ||= self.event.seats
    self.waitlisted = (event_all_seats <= event_seats_taken)
    true
  end

  def change_waitlist_to_attending
    self.waitlisted=false
    self.save
    AttendeeMailer.delay.notify_waitlisted(self)
  end

  def update_event_waitlist
    self.event.update_waitlist
  end

end
