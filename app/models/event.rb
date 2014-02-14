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

  def date_checker
    if date.blank? || date < Date.today
      errors.add(:date, " should be filled and should be in the future.")
    end
  end

end
