# frozen_string_literal: true

require 'rest-client'
require 'json'

module Services
  class StibRequest
    WAITING_TIME_URL = 'https://opendata-api.stib-mivb.be/OperationMonitoring/3.0/PassingTimeByPoint'
  
    def self.waiting_time(stop_ids)
      response = RestClient.get(WAITING_TIME_URL + "/#{stop_ids.join("%2C")}", Authorization: "Bearer #{ENV['STIB_API_TOKEN']}")
      JSON.parse(response)
    end
  end  
end