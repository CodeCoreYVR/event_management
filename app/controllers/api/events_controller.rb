class Api::EventsController < Api::ApplicationController

  def index
    @events = Event.future_events.order("date ASC")
    @events.map { |e| EventSerializer.new(e, root: false) }
    render json: @events, root: false
  end

  def register
    @attendee = Attendee.find_by_email(attendee_params[:email]) ||
                Attendee.new(attendee_params)

    @attendee.event_ids ||= []
    @attendee.event_ids << params[:event_id]

    if @attendee.save
      AttendeeMailer.delay.notify_attendee(@attendee)
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  private

  def attendee_params
    params.require(:attendee).permit([:name, :company, :email])
  end

end
