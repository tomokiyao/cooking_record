class Bookmark < ApplicationRecord
  validates :image_url, presence: true

  enum recipe_type: { main_dish: 0, side_dish: 1, soup: 2 }
end
