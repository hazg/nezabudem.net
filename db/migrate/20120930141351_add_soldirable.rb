class AddSoldirable < ActiveRecord::Migration
  def change
    add_column :soldiers, :soldirable_id, :integer
    add_column :soldiers, :soldirable_type, :string, :limit => 32

    add_index :soldiers, :soldirable_id
    add_index :soldiers, :soldirable_type

  end
end
