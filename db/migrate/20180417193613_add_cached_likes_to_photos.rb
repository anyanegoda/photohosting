class AddCachedLikesToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :cached_votes_total, :integer, default: 0
    add_column :photos, :cached_votes_score, :integer, default: 0
    add_column :photos, :cached_votes_up, :integer, default: 0
    add_column :photos, :cached_votes_down, :integer, default: 0
    add_column :photos, :cached_weighted_score, :integer, default: 0
    add_column :photos, :cached_weighted_total, :integer, default: 0
    add_column :photos, :cached_weighted_average, :float, default: 0
  end
end
