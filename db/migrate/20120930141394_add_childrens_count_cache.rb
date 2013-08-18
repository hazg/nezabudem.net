class AddChildrensCountCache < ActiveRecord::Migration
  def change
    add_column :places, :childrens_count, :integer, :default => false
    add_column :places, :ancestry_depth, :integer, :default => 0
    Place.transaction do
      Place.all.each{|x| x.save!}
    end
  end
end
