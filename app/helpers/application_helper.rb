module ApplicationHelper
  def truncate_s(input,len)
    input.truncate(len,omission: "...")
  end
end
