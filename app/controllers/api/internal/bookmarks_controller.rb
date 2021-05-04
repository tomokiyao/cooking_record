module Api
  module Internal
    class BookmarksController < ApplicationController
      def index
        render json: { bookmarks: Bookmark.all }, status: 200
      end

      def create
        bookmark = Bookmark.new(bookmark_params)
        if bookmark.save
          render json: { bookmarks: Bookmark.all }, status: 200
        else
          render json: { errors: bookmark.errors.full_messages }, status: 400
        end
      end

      private

      def bookmark_params
        params.require(:bookmark).permit(:image_url, :comment, :recipe_type)
      end
    end
  end
end
