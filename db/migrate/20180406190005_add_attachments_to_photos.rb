class AddAttachmentsToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :attachments, :json
  end
end
