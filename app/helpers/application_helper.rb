module ApplicationHelper

  def fix_url(str)
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def display_datetime(dt)
    dt.strftime("%d/%m/%Y %l:%M%P %Z") # will display it as so 28/08/2012 8:09pm GMT
  end

end
