class Api::EventsController < ApplicationController

  def index
    @events = Event.future_events.order("date ASC")
    @events.map { |e| EventSerializer.new(e, root: false) }
    render json: @events, root: false
  end

end
