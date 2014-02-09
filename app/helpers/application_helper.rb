module ApplicationHelper

  def formatted_date(date)
    date.strftime("%d-%B-%Y")
  end
end
