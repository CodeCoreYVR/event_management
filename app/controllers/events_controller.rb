class EventsController < ApplicationController

  def index
    @events = Event.all.order("date ASC")
    @attendee = Attendee.new
  end

end