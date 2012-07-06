class PlacePhoto < ActiveRecord::Base
  include Placeable
  belongs_to :user
  has_many :soldiers, :as => :soldirable
  scope :need_ocr, where(:need_ocr => true)
  validates :photo, :presence => true
  #:user, :user_id,
  attr_accessible :need_ocr, :description, :user_id, :title, :photo_at, :place_id, :photo
  #accepts_nested_attributes_for :user
  #acts_as_taggable
  #acts_as_taggable_on :tags
  mount_uploader :photo, PhotoUploader
  #def photable_type=(sType)
  #   super(sType.to_s.classify.constantize.base_class.to_s)
  #end
  def photo=(obj)
    super(obj)
  end

end
