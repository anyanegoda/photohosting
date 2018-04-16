class ChangeColumnImage < ActiveRecord::Migration[5.0]
  def up
    change_column :photos, :image, :string, null: true
  end
  def down
    change_column :photos, :image, :string, null: false
  end
end
