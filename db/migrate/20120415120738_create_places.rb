class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.float   :lat
      t.float   :lng
      t.string  :title
      t.string  :name
      t.string  :address
      t.string  :status
      t.text    :description
      t.string  :type
      t.boolean :is_around
      t.string  :kind
      t.integer :zoom
      t.string  :slug

      t.timestamps
    end
    add_index :places, :slug, unique: true
    add_index :places, :address
    add_index :places, :type
    add_index :places, :name
    add_index :places, :lat
    add_index :places, :lng
    add_index :places, :kind
  end
end
