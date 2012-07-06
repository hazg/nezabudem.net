class AddUserToSoldier < ActiveRecord::Migration
  def change
    add_column :soldiers, :user_id, :integer
    add_index :soldiers, :user_id
  end
end
