class Attendance < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :event
  validates_uniqueness_of :attendee_id, :scope => :event_id

  before_create :waitlist_check

  #validate :cap_check
  # def cap_check
  #   event_seats_taken=event.attendances.length
  #   if (event.seats <= event_seats_taken)
  #     errors.add(:event_id," #{event.title} has been filled. Sorry!" )
  #   end
  # end

  scope :with_seats, -> {where("NOT waitlisted or waitlisted is NULL")}

  scope :waiting, -> {where("waitlisted").order('created_at ASC')}

  def waitlist_check
    event_seats_taken ||= self.event.seat_ownerships.length
    event_all_seats ||= self.event.seats
    if (event_all_seats <= event_seats_taken)
      self.waitlisted=true
    else
      self.waitlisted=false
    end
    true
  end

  def change_waitlist_to_attending
    self.waitlisted=false
    self.save
  end


end
