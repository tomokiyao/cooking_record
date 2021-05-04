class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :recipe_type, null: false, default: 0
      t.text :comment
      t.text :image_url, null: false

      t.timestamps
    end
  end
end
