class AddSeatsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :seats, :integer
  end
end
