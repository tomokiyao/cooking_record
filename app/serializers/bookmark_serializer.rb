class BookmarkSerializer < ActiveModel::Serializer
  attributes :comment, :image_url, :recipe_type, :bookmark

  def bookmark
    true
  end
end
