class AttendeesController < ApplicationController

  def create
    @attendee = Attendee.new attendee_params
    if event_number_check && @attendee.save
      AttendeeMailer.delay.notify_attendee(@attendee)
    else
      @events = Event.all
      flash.now[:alert]=@message || ''
      render 'events/index'
    end
  end

  
  private

  def attendee_params
    params.require(:attendee).permit([:name, :company, :mail_list, :email, {event_ids: []}, {category_ids: []}])
  end

  def event_number_check
    eventids

    if (!@event_ids || @event_ids.length > 2)
      @message = "You have to choose 1 or 2 events."
      false
    else
      true
    end
  end

  def eventids
    @event_ids ||= params[:attendee][:event_ids]
  end

end