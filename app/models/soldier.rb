class Soldier < ActiveRecord::Base
  include Placeable
  has_paper_trail

  belongs_to :user, :counter_cache => true
  belongs_to :soldirable, :polymorphic => true, :counter_cache => true
  define_index do
    indexes fio
    #has user_id, place_id, soldirable_id, soldirable_type
  end
end
