class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :photos, :photo_url, :image
  end
end
