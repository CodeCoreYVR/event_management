class Admin::AttendeesController < ApplicationController
  before_action :find_attendee, except: :index
  before_action :authenticate_user!
  def edit
  end

  def index
    @attendees=Attendee.all
  end

  def update
    if (@attendee.update_attributes(attendee_params))
      redirect_to admin_attendees_path, notice: "Changes saved."
    else
      render :edit, alert: "Maybe next time. Don't give up."
    end
  end

  def destroy
    if @attendee.destroy
      redirect_to admin_attendees_path, notice: "Event deleted successfully"
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

end
