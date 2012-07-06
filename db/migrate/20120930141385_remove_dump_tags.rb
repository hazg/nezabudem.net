class RemoveDumpTags < ActiveRecord::Migration
  include ApplicationHelper
  def up
    Place.all.each do |x|
      x.tag_list.remove( [_('need_ocr'), _('tags.no_photos')] )
      x.save
    end
  end

  def down
  end
end
