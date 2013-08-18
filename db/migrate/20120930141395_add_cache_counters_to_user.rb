class AddCacheCountersToUser < ActiveRecord::Migration
  def change
    add_column :users, :soldiers_count, :integer, :default => 0
    add_column :users, :place_photos_count, :integer, :default => 0
    add_column :users, :places_count, :integer, :default => 0
    add_column :users, :comments_count, :integer, :default => 0
     User.transaction do
      User.order('id DESC').all.each do |u|
        User.reset_counters(u.id, :places)
        User.reset_counters(u.id, :place_photos)
        User.reset_counters(u.id, :soldiers)
        User.reset_counters(u.id, :comments)
        #User.reset_counters(u.id, :soldiers)
        #User.update_counters(u.id,
        #  :soldiers_count => u.soldiers.count,
        #  :place_photos_count => u.place_photos.count,
        #  :places_count => u.places.count,
        #  :comments_count => Comment.find_comments_by_user(u)
        #)
        
        begin
          u.save!
        rescue ActiveRecord::RecordInvalid => invalid
          u.nick += '1'
          p "#{u.nick} #{u.id}"
          u.save!
        end
      end
    end
  end
end
