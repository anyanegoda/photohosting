class RemoveLikes < ActiveRecord::Migration[5.0]
  def change
    remove_column :photos, :attachments
    remove_column :photos, :likes
  end
end
