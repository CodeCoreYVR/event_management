class AttendeesController < ApplicationController

  def index
    @attendees = Attendee.all
  end

  def create
    @attendee = Attendee.new attendee_params
    @attendee.save
  end

  def new
    @attendee = Attendee.new
  end

  def attendee_params
    params.require(:attendee).permit([:name, :company, :email, {category_ids: []}])
  end
end
