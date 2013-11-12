class Profile < ActiveRecord::Base
  belongs_to :user
  attr_accessible :about, :fio, :user, :user_id, :nick
  accepts_nested_attributes_for :user
  
  def nick
    user.nick
  end

end
