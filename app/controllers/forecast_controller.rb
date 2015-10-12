require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================
    url = "https://api.forecast.io/forecast/e252d9a70e7c1d9a8e10993041114ee5/#{@lat},#{@lng}"
    raw_data_from_darksky = open(url).read
    hash_from_darksky = JSON.parse(raw_data_from_darksky)

    @current_temperature = hash_from_darksky["currently"]["temperature"]

    @current_summary = hash_from_darksky["currently"]["summary"]

    @summary_of_next_sixty_minutes = hash_from_darksky["minutely"]["summary"]

    @summary_of_next_several_hours = hash_from_darksky["hourly"]["summary"]

    @summary_of_next_several_days = hash_from_darksky["daily"]["summary"]

    render("coords_to_weather.html.erb")
  end
end
