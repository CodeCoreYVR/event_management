class Attendance < ActiveRecord::Base
  belongs_to :attendee
  belongs_to :event


end
