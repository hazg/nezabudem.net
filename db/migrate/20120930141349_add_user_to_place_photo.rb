class AddUserToPlacePhoto < ActiveRecord::Migration
  def change
    add_column :place_photos, :user_id, :integer
    add_index :place_photos, :user_id
  end
end
