class Attendance < ActiveRecord::Base
  has_many :attendees
  has_many :events
end
