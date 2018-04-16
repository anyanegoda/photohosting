class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :photo_url, null: false
      t.integer :views
      t.integer :likes
      t.integer :downloads
      t.text :tags, array: true, default: []

      t.timestamps
    end
  end
end
