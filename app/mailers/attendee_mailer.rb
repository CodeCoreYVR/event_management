class AttendeeMailer < ActionMailer::Base
  default from: "events@codecore.ca"
  add_template_helper(ApplicationHelper)

  def notify_attendee (attendee)
    @attendee = attendee
    @email = @attendee.email
    @events = @attendee.events
    mail(to:@email, subject: "Congrats! You've signed up!")
  end
end