class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :attendance
  has_many :attendees, through: :attendance
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_size :image, less_than: 10.megabytes
end
