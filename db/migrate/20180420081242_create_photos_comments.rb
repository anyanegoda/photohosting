class CreatePhotosComments < ActiveRecord::Migration[5.0]
  def change
    create_table :photos_comments do |t|
      t.text :body
      t.references :user, foreign_key: true
      t.references :photo, foreign_key: true

      t.timestamps
    end
  end
end
