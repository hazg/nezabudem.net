class Place < ActiveRecord::Base
  include ApplicationHelper
  acts_as_commentable
  has_paper_trail
  #attr_accessor :updating_childrens_count
  
  #after_save :cache_childrens_count, :unless => :updating_childrens_count
  #after_update :cache_childrens_count, :unless => :updating_childrens_count

  belongs_to :user, :counter_cache => true
  

  paginates_per 10
  has_ancestry :cache_depth => true #:orphan_strategy => :rootify, 
  
  has_many :photos, :class_name => 'PlacePhoto', :dependent => :destroy
  #attr_accessible :name, :parent_id 
  
  validates :name, :presence => true
  validates :address, :presence => true
  validates :lat, :presence => true, :unless => :node?
  validates :lng, :presence => true, :unless => :node?
  scope :by_bounds, lambda{|x1,y1,x2,y2,options| get_in_bounds(x1, y1, x2, y2, options) }
  scope :without_nodes, where('kind <> "node"')
          
    #select("(SELECT COUNT(id) FROM place_photos WHERE place_id = `places`.id) AS cnt").where('cnt IS NULL')
  
  #<F8>scope :need_photos, lambda{joins(:photos).having(:photos => nil)}
  scope :need_ocr, lambda{Place.without_nodes.where(:id =>  PlacePhoto.where(:need_ocr=>true).select(:id))}
  scope :need_photos, without_nodes.where(:place_photos_count => false)

  def need_ocr?
    self.photos.where(:need_ocr => true).any?
  end

  def need_photos?
    self.place_photos_count.to_i < 1
  end
  
  def has_places?
    self[:childrens_count] > 0
  #  if force
  #    self.subtree.where('kind <> "node" AND id <> ' + self.id.to_s).count > 0
  #  else
  #    self[:places_count]
  #  end
  end
  
  def self.get_in_bounds(x1, y1, x2, y2, options)
    
    cond = %{
      lat IS NOT NULL AND lng IS NOT NULL AND
      #{(options['outside'] ? 'NOT':'')} ( lat > #{x1} AND lng > #{y1} AND lat < #{x2} AND lng < #{y2} )
    }
    
    select([:id, :name, :lat, :lng, :kind]).where(cond)
  end

  def node?
    (kind == 'node')
  end

  def name
    (self[:name].nil? ? self[:address] : self[:name])
  end

  def full_address
    path.map{|x| x.address}.join ', '
  end
end
