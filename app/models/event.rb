class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :attendance
  has_many :attendees, through: :attendance
end
