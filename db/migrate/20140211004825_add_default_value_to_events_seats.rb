class AddDefaultValueToEventsSeats < ActiveRecord::Migration
  def change
    change_column :events, :seats, :integer, default: 0
  end
end
