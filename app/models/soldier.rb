class Soldier < ActiveRecord::Base
  include Placeable
  belongs_to :soldirable, :polymorphic => true
  belongs_to :user
end
