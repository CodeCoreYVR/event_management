class AttendeeMailer < ActionMailer::Base
  default from: "events@codecore.ca"
  add_template_helper(ApplicationHelper)

  def notify_attendee (attendee)
    @attendee = attendee
    email = @attendee.email
    @has_seat_events = @attendee.confirmed_events
    @waitlist_events = @attendee.waitlisted_events
    mail(to:email, subject: "Congrats! You've signed up!")
  end

  def notify_waitlisted (attendance)
    @attendee = attendance.attendee
    @email = @attendee.email
    @event = attendance.event
    mail(to:@email, subject: "There is a spot for you on #{@event.speaker}'s talk!")
  end
end