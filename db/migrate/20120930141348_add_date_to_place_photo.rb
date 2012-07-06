class AddDateToPlacePhoto < ActiveRecord::Migration
  def change
    add_column :place_photos, :photo_at, :datetime
  end
end
