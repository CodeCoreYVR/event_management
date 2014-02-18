class EventsController < ApplicationController

  def index
    @events = Event.future_events.order("date ASC")
    @attendee = Attendee.new
  end

end