class AttendeesController < ApplicationController



  def create
    @attendee = Attendee.new attendee_params
    if event_number_check && @attendee.save
    else
    @events = Event.all
    flash.now[:alert]=@message
    render "/events/index"
    end
  end

  

  def attendee_params
    params.require(:attendee).permit([:name, :company, :mail_list, :email, {event_ids: []}, {category_ids: []}])
  end

private
  def event_number_check
    @message="Unknown issue."
    if (!eventids)
      @message="You have to choose 1 or 2 events."
      false
    elsif eventids.length>2
      @events = Event.all
      false
    else
      true
    end
  end

  def eventids
    params[:attendee][:event_ids]
  end


end
