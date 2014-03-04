class EventsController < ApplicationController

  def index
    @events = Event.future_events.order("date ASC")
    @past_events = Event.past_events.order("date DESC")
    @attendee = Attendee.new
  end

end