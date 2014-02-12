module ApplicationHelper

  def formatted_date(date)
    date.strftime("%a, %b %m, %Y")
  end
  def formatted_time(date)
    date.strftime("%I:%M %p")
  end
end
