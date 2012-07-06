class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :photo
      t.integer :user_id
      t.timestamps
    end
    add_index :avatars, :user_id
  end
end
