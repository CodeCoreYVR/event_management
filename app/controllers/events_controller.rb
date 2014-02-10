class EventsController < ApplicationController

  def index
    @events = Event.all
    @attendee = Attendee.new
  end

  def black
    @events = Event.all
    @attendee = Attendee.new
  end
end
