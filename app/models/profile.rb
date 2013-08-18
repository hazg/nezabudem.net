class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :about, :fio, :user, :user_id
  accepts_nested_attributes_for :user
  
end
