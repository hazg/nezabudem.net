# This migration comes from scrib_engine (originally 20111029140253)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :title, :lenght => 1024
      t.string :head, :lenght => 1024
      t.text :body, :limit => 16777215 #MEDIUMTEXT
      t.string  :slug_md5, :lenght => 32
      t.string  :slug, :lenght => 1024
      t.integer :user_id
      t.timestamps
    end
    add_index :pages, :slug_md5
  end
end
