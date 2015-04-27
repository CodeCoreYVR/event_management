class EventSerializer < ActiveModel::Serializer
  attributes :id, :title, :remaining, :presenter, :presenter_image_url,
    :splash_image_url, :bio, :description, :date, :time, :is_registered,
    :twitter, :facebook, :linkedin

  def is_registered
    if (email = serialization_options[:email])
      object.confirmed_attendees.where(email: email).count > 0
    end
  end

  def title
    object.title
  end

  def remaining
    object.seats - object.confirmed_attendees.count
  end

  def presenter
    object.speaker
  end

  def description
    object.long_description
  end

  def presenter_image_url
    object.image.url(:thumb)
  end

  def splash_image_url
    object.splash_image_url
  end

  def bio
    object.bio
  end

  def date
    return '' if object.date.nil?
    object.date.strftime('%A, %b %d')
  end

  def time
    # Lazy
    return '12:00 PM - 01:00 PM'
  end
end
