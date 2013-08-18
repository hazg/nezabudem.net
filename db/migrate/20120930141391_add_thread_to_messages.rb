class AddThreadToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :thread, :integer
    add_index :messages, :thread
  end
end
