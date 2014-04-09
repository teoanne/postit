module ApplicationHelper

  def fix_url(str)
    str.starts_with?("http://" || "https://") ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? and !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone) #in_time_zone is a rails 4 helper method
    end
    dt.strftime("%d/%m/%Y %l:%M%P %Z") # will display it as so 28/08/2012 8:09pm GMT
  end

end
