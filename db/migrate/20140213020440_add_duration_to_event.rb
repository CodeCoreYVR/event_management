class AddDurationToEvent < ActiveRecord::Migration
  def change
    add_column :events, :duration, :integer, default: 15
  end
end
