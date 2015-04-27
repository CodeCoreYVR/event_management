class Api::EventsController < Api::ApplicationController

  def index
    @events = Event.future_events.order("date ASC")
    @events.map { |e| EventSerializer.new(e) }
    render json: @events, root: false, email: params[:email]
  end

  def register
    @attendee = Attendee.find_by_email(attendee_params[:email]) ||
                Attendee.new(attendee_params)

    @event = Event.find(params[:event_id]);
    @attendee.events ||= []
    @attendee.events << @event

    if @attendee.save
      AttendeeMailer.delay.notify_attendee(@attendee)
      render json: EventSerializer.new(@event, root: false), root: false
    else
      render json: {success: false}
    end
  end

  private

  def attendee_params
    params.require(:attendee).permit([:name, :company, :email])
  end

end
