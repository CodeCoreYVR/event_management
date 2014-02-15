class AddWaitlistedToAttendance < ActiveRecord::Migration
  def change
    add_column :attendances, :waitlisted, :boolean
  end
end
