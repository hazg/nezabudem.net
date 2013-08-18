class AddPathToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :address_path, :string
    add_index :places, :address_path
    ActiveRecord::Base.connection.execute('UPDATE places SET address_path = LOWER(address)')
    Place.without_nodes.each do |x|
      x.save
    end
  end


end
