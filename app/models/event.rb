class Event < ActiveRecord::Base
  belongs_to :user
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path('/:style/missing.png')

  validates_attachment_size :image, less_than: 10.megabytes

  validate :date_checker

  # validates :event, presence: true {maximum}

 



  def date_checker
    if date.blank? || date < Date.today
      errors.add(:date, " should be filled and should be in the future.")
    end
  end
end
