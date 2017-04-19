require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@street_address

    parsed_data = JSON.parse(open(url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    key = "738130ff27ade86172e5b00a210c7443"

    url_forecast = "https://api.darksky.net/forecast/" + key + "/" + latitude.to_s + "," + longitude.to_s

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

    render("meteorologist/street_to_weather.html.erb")
  end
end
