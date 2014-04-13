class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances
  validates_numericality_of :seats
  validate :date_checker
  has_attached_file  :image,
                     storage: :s3,
                     s3_protocol: "https",
                     preserve_files: true,
                     :s3_credentials => {
                        bucket: "corecore-events",
                        access_key_id: ENV["s3_id"],
                        secret_access_key: ENV["s3_access_key"]
                      },
                     styles: { :medium => "200x200>", :thumb => "100x100>", display: "100000x79>", medium: "100000x79>", print: "100000x198>" },
                       path: "/image/:id/:style/:filename",
                     :default_url => 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTdsjWnPtvccjwXi18Hbab91KDKChPoWSMCF0maMUBMjSuwAKQL'

  validates_attachment_size :image, less_than: 10.megabytes   
  
  scope :future_events, -> {where("date > ?",Time.now)}

  after_update :update_waitlist

  def self.past_events
    where(date: (Time.now - 2.weeks)..Time.now).order("date DESC")
  end

  def confirmed_attendees
    Attendee.joins(:attendances).where("attendances.id in (?)", seat_ownerships.ids)
  end

  def waitlisted_attendees
    Attendee.joins(:attendances).where("attendances.id in (?)", wait_listed.ids)
  end

  def seat_ownerships
    self.attendances.with_seats
  end

  def wait_listed
    self.attendances.waiting
  end

  def date_checker
    if date.blank? || date < Date.today
      errors.add(:date, " should be filled and should be in the future.")
    end
  end

  def update_waitlist
    waitlisted = self.wait_listed()
    taken = self.seat_ownerships.count()
    index = 0
    while seats > taken and index < waitlisted.length
      waitlisted[index].change_waitlist_to_attending()
      index+=1
      taken+=1
    end
  end

end
