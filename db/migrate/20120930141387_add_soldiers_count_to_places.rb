class AddSoldiersCountToPlaces < ActiveRecord::Migration
  def up
    add_column :places, :soldiers_count, :integer
    add_index :places, :soldiers_count
    Place.all.map{|p| 
      p.soldiers_count = p.soldiers.size
      p.save
    }
  end
end
