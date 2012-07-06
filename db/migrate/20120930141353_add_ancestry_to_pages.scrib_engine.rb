# This migration comes from scrib_engine (originally 20120113094645)
class AddAncestryToPages < ActiveRecord::Migration
  def change
    add_column :pages, :ancestry, :string
    add_index :pages, :ancestry
  end
end
