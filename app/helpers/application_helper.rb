module ApplicationHelper
  def photo_date(date)
    t = Time.now.to_i
    date_s = date.to_i

    dif_in_sec = t - date_s
    if dif_in_sec > 60
      dif_in_min = dif_in_sec / 60
      if dif_in_min > 60
        dif_in_hour = dif_in_min / 60
        if dif_in_hour > 24
          dif_in_day = dif_in_hour / 24
          if dif_in_day > 7
            dif_in_week = dif_in_day / 7
            dif_in_week.to_s + ' week'
          else
            dif_in_day.to_s + ' days'
          end
        else
          dif_in_hour.to_s + ' hours'
        end
      else
        dif_in_min.to_s + ' minutes'
      end
    else
      dif_in_sec.to_s + ' seconds'
    end

  end
end
