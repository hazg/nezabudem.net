class AddPlacePhotosCountToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :place_photos_count, :integer
    add_index :places, :place_photos_count
    Place.all.map{|p| 
      p.place_photos_count = p.photos.size
      p.save
    }
  end
end
