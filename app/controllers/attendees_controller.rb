class AttendeesController < ApplicationController

  def create
    @attendee = Attendee.new attendee_params
    if @attendee.save
      AttendeeMailer.delay.notify_attendee(@attendee)
    else
      @events = Event.all
      @message ||= ''
      model_validation_messages
      redirect_to root_path + '#section-signup', alert: @message+@errs
    end
  end

  
  private

  def model_validation_messages
    if @attendee.errors.any?
      @attendee.errors.delete(:attendances)
      @errs = @attendee.errors.full_messages.join(" and ")
      @errs+=" and " unless @errs.blank?
      @errs += (@attendee.attendances.map{ |x| x.errors.full_messages.join(" and ") }).join(" and ")
    end
    @errs||= ''
  end

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