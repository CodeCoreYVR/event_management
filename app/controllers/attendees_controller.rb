class AttendeesController < ApplicationController

  def create
    @attendee            = Attendee.find_by_email(attendee_params[:email]) || Attendee.new(attendee_params)
    begin 
      @attendee.categories += Category.find(attendee_params[:category_ids].delete_if{|x| x.empty?} )
      @attendee.events     += Event.find(attendee_params[:event_ids])
    rescue
    end
    if event_number_check && @attendee.save
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
    if params[:attendee][:event_ids].present?
      true
    else
      @message = "You have to choose 1 or 2 events."
      false
    end
  end

end