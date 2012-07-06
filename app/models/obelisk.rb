class Obelisk < Place
  include YandexMapAncestry
  has_many :soldiers, :foreign_key => :place_id #:class_name => "Soldier"
  include ActsAsTaggableOn::TagsHelper  
  
  #self.abstract_class = true
  #TODO: Делать через :
  # set_table_name 'Obelisk'
  
  
  accepts_nested_attributes_for :soldiers

end
