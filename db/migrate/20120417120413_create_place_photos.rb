class CreatePlacePhotos < ActiveRecord::Migration
  def change
    create_table :place_photos do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.integer :place_id
      
      t.timestamps
    end

    add_index :place_photos, :place_id
  end
end
