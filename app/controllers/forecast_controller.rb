require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    key = "738130ff27ade86172e5b00a210c7443"

    url_forecast = "https://api.darksky.net/forecast/" + key + "/" + @lat + "," + @lng

    parsed_data_forecast = JSON.parse(open(url_forecast).read)
    curr_temp = parsed_data_forecast["currently"]["temperature"]
    curr_sum = parsed_data_forecast["currently"]["summary"]
    min_sum = parsed_data_forecast["minutely"]["summary"]
    hr_sum = parsed_data_forecast["hourly"]["summary"]
    daily_sum = parsed_data_forecast["daily"]["summary"]

    @current_temperature = curr_temp

    @current_summary = curr_sum

    @summary_of_next_sixty_minutes = min_sum

    @summary_of_next_several_hours = hr_sum

    @summary_of_next_several_days = daily_sum

    render("forecast/coords_to_weather.html.erb")
  end
end
