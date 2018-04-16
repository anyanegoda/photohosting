class CreateCollectionsPhotosJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :collections, :photos do |t|
    t.index :collection_id
    t.index :photo_id
  end
  end
end
