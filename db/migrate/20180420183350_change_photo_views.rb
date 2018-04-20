class ChangePhotoViews < ActiveRecord::Migration[5.0]
  def up
    change_column :photos, :views, :integer, default: 0
    change_column :photos, :downloads, :integer, default: 0
  end
  def down
    change_column :photos, :views, :integer
    change_column :photos, :downloads, :integer
  end
end
