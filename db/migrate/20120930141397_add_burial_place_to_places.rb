class AddBurialPlaceToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :bural_place, :boolean
  end
end
