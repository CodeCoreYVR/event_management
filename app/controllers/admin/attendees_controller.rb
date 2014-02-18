class Admin::AttendeesController < ApplicationController
  before_action :find_attendee, except: :index
  before_action :authenticate_user!
  def edit
  end

  def index
    @attendees=Attendee.all
  end

  def update
    before_events=Array.new(@attendee.events)
    if (@attendee.update_attributes(attendee_params))
      after_events=@attendee.events
      update_removed_events(before_events,after_events)
      redirect_to admin_attendees_path, notice: "Changes saved."
    else
      render :edit, alert: "Maybe next time. Don't give up."
    end
  end

  def destroy
    if @attendee.destroy
      redirect_to admin_attendees_path, notice: "Attendee deleted successfully"
    else
      redirect_to admin_attendees_path, alert: "Problem man"
    end
  end

private
  def find_attendee
    @attendee = Attendee.find params[:id]
  end
  def attendee_params
    params.require(:attendee).permit([:name, :company, :mail_list, :email, {event_ids: []}, {category_ids: []}])
  end

  def update_removed_events(before,after)
    removed_events=before-after
    removed_events.each do |removed|
        removed.update_waitlist
    end
  end
end
