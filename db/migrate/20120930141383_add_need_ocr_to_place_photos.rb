# @encoding: utf-8
class AddNeedOcrToPlacePhotos < ActiveRecord::Migration
  def up
    add_column :place_photos, :need_ocr, :boolean, :default => false
    add_index :place_photos, :need_ocr
    PlacePhoto.all.each do |pp|
      if not pp.tags.named("нуждаeтся в оцифровке").empty?
        
        pp.need_ocr = true
        pp.tag_list.remove("нуждаeтся в оцифровке")
        pp.save_tags
        pp.save
      end
    end

  end
  def down
    remove_column :place_photos, :need_ocr
  end
end
