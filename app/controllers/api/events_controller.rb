class Api::EventsController < Api::ApplicationController

  def index
    if params[:sample].present?
      @events = Event.sample_events.order("date ASC")
    else
      @events = Event.future_events.order("date ASC")
    end

    @events.map { |e| EventSerializer.new(e) }
    render json: @events, root: false, email: params[:email]
  end

  def register
    @attendee = Attendee.where(email: attendee_params[:email]).first

    if @attendee.nil?
      @attendee = Attendee.new(attendee_params)
    end

    @event = Event.find(params[:event_id])

    unless @attendee.events.include?(@event)
      @attendee.events << @event
    end

    if @attendee.save
      AttendeeMailer.delay.notify_attendee(@attendee)
      @events = Event.future_events.order("date ASC")
      @events.map { |e| EventSerializer.new(e) }

      render json: @events, root: false, email: @attendee.email
    else
      render json: {success: false}
    end
  end

  private

  def attendee_params
    params.require(:attendee).permit([:name, :company, :email])
  end

end
