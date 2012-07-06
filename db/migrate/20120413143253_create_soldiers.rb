class CreateSoldiers < ActiveRecord::Migration
  def change
    create_table :soldiers do |t|
      t.string :fio
      t.string :name1
      t.string :name2
      t.string :name3

      
      t.timestamps
    end
    add_column :soldiers, :place_id, :integer
    add_index :soldiers, :place_id
  end
end
