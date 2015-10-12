require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    url_safe_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the string url_safe_street_address.
    # ==========================================================================

    google_url ="http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_street_address

    raw_data_from_google = open(google_url).read
    loc_data_from_google  = JSON.parse(raw_data_from_google)
    lat = loc_data_from_google["results"][0]["geometry"]["location"]["lat"]
    long = loc_data_from_google["results"][0]["geometry"]["location"]["lng"]

    darksky_url = "https://api.forecast.io/forecast/e252d9a70e7c1d9a8e10993041114ee5/#{lat},#{long}"
    raw_data_from_darksky = open(darksky_url).read
    hash_from_darksky = JSON.parse(raw_data_from_darksky)

    @current_temperature = hash_from_darksky["currently"]["temperature"]

    @current_summary = hash_from_darksky["currently"]["summary"]

    @summary_of_next_sixty_minutes = hash_from_darksky["minutely"]["summary"]

    @summary_of_next_several_hours = hash_from_darksky["hourly"]["summary"]

    @summary_of_next_several_days = hash_from_darksky["daily"]["summary"]

    render("street_to_weather.html.erb")
  end
end
