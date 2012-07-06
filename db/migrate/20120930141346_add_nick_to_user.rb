class AddNickToUser < ActiveRecord::Migration
  def change
    add_column :users, :nick, :string, :lenght => 12
  end
end
