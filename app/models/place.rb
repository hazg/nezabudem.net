class Place < ActiveRecord::Base
  include ApplicationHelper
  include ActsAsTaggableOn::TagsHelper
  
  #acts_as_taggable
  #acts_as_taggable_on :tags

  after_save :prepare_tags
  after_update :prepare_tags
  belongs_to :user
  
  paginates_per 10
  has_ancestry #:orphan_strategy => :rootify
  
  has_many :photos, :class_name => 'PlacePhoto', :dependent => :destroy

  
  validates :name, :presence => true
  validates :address, :presence => true
  validates :lat, :presence => true
  validates :lng, :presence => true
  scope :by_bounds, lambda{|x1,y1,x2,y2,options| get_in_bounds(x1, y1, x2, y2, options) }
  scope :without_nodes, where('kind <> "node"')
          
    #select("(SELECT COUNT(id) FROM place_photos WHERE place_id = `places`.id) AS cnt").where('cnt IS NULL')
  
  #<F8>scope :need_photos, lambda{joins(:photos).having(:photos => nil)}
  scope :need_ocr, lambda{Place.without_nodes.where(:id =>  PlacePhoto.where(:need_ocr=>true).select(:id))}
  scope :need_photos, without_nodes.where(:place_photos_count => false)

  def need_ocr?
    !self.photos.where(:need_ocr => true).limit(1).empty?
  end

  def need_photos?
    self.place_photos_count.to_i < 1
  end

  def has_places?
    self.subtree.where('kind <> "node" AND id <> ' + self.id.to_s).size > 0
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
    (self[:name].blank? or self[:name].nil?) ? self[:address] : self[:name]
  end

  def full_address
    path.map{|x| x.address}.join ', '
  end

  private

  def prepare_tags
  end
end

=begin
class ActiveRecord::Reflection::AssociationReflection
  def build_association(*options)
    if options.first.is_a?(Hash) and options.first[:type].presence
      options.first[:type].to_s.constantize.new(*options)
    else
      klass.new(*options)
    end
  end
end
=end
