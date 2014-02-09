class Admin::EventsController < ApplicationController
  #before_action :authenticate_user!,only: [:create,:new,:update,:edit,:destroy,:adminindex]
  before_action :find_event, only: [:edit, :show, :destroy, :update]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def edit

  end

  def create
    @event = Event.new event_params
    if @event.save
      redirect_to [:admin, :events] , notice: "Event created successfully"
    else
      render :new, alert: "You suck"
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to [:admin, @event], notice: "Event updated successfully"
    else
      render :edit, alert: "You suck"
    end
  end

  def destroy
    if @event.destroy
      redirect_to events_path, notice: "Event deleted successfully"
    else
      redirect_to events_path, alert: "Problem mang"
    end
  end

  def show
  end

  private

  def event_params
    params.require(:event).permit([:image,:title, :body, :seats, :date, :speaker, :address, :bio, :linkedin, :facebook, :twitter])
  end

  def find_event
    @event = Event.find params[:id]
  end
end
