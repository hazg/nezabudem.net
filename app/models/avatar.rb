# User.all.each do |user| user.avatar.photo.recreate_versions! end

class Avatar < ActiveRecord::Base
  attr_accessible :photo
  belongs_to :user, :dependent => :destroy
  mount_uploader :photo, AvatarUploader
  
  def photo=(obj)
    super(obj)
  end

end
