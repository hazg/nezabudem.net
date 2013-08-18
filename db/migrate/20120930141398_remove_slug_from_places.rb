class RemoveSlugFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :slug
  end
end
