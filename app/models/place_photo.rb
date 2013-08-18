#encoding: utf-8
class PlacePhoto < ActiveRecord::Base
  include Placeable
  acts_as_commentable
  
  
  belongs_to :user, :counter_cache => true
  #belongs_to :place, :counter_cache => true # IN PLACEABLE
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
  #
  def name
    if self.attributes[:name].blank?
      I18n.t('place_photo.without_title', :place_name => place.name, :photo_id => id)
    else
      self.name
    end
  end

  def image
    @image ||= MiniMagick::Image.open(photo.path)
  end

  def previous(lim = 1)
    place.photos.where("id < #{self.id}").order('id DESC').limit(lim)
  end
  def next(lim = 1)
    place.photos.where("id > #{self.id}").order('id ASC').limit(lim)
  end

  def around(lim = 1, include_self = true)
    p = self.previous(lim)
    n = self.next(lim + (lim - p.count) )
    r = []
    r += p.reverse if not p.nil?
    r += [self] if include_self
    r += n if not n.nil?
    r
  end
  
  def photo=(obj)
    super(obj)
  end

end
