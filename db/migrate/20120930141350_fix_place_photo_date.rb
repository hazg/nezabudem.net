class FixPlacePhotoDate < ActiveRecord::Migration
  def change
    change_column :place_photos, :photo_at, :date
  end
end
