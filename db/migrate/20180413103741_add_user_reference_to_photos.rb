class AddUserReferenceToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_reference :photos, :user, foreign_key: true
    #add_foreign_key :photos, :users
  end
end
