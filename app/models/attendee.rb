class Attendee < ActiveRecord::Base
  belongs_to :categorization
  belongs_to :atendance
  has_many :events, through: :attendance
  has_many :categories, through: :categorization
end
