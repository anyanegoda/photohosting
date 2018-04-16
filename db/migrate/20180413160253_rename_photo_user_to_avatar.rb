class RenamePhotoUserToAvatar < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :photo, :avatar
  end
end
