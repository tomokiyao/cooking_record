module Api
  module Internal
    class FetchCookingRecordsController < ApplicationController
      def index
        uri = URI(
          "https://cooking-records.herokuapp.com/cooking_records?offset=#{params[:offset]}&limit=6"
        )
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        req = Net::HTTP::Get.new(uri)
        res = http.request(req)
        render json: rebuilding(res), status: 200
      end

      private

      def rebuilding(res)
        json = JSON.parse(res.body)
        bookmark_image_urls = Bookmark.pluck(:image_url)
        json["cooking_records"].map do |h|
          h["bookmark"] = bookmark_image_urls.include?(h["image_url"])
        end
        json
      end
    end
  end
end
