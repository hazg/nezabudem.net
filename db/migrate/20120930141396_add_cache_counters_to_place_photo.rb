class AddCacheCountersToPlacePhoto < ActiveRecord::Migration
  def change
    add_column :place_photos, :soldiers_count, :integer, :default => 0
     User.transaction do
      User.order('id DESC').all.each do |u|
        User.reset_counters(u.id, :soldiers)
        
        begin
          u.save!
        rescue ActiveRecord::RecordInvalid => invalid
          p "#{u.id} #{invalid.errors}"
        end
      end
    end
  end
end
