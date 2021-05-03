module Api
  module Internal
    class FetchCookingRecordsController < ApplicationController
      def index
        uri = URI("https://cooking-records.herokuapp.com/cooking_records")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri)
        res = http.request(req)
        render json: JSON.parse(res.body), status: 200
      end
    end
  end
end
