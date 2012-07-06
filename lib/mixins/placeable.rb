module Placeable
  def self.included(base)
    base.class_eval {
      belongs_to :place, :counter_cache => true
    }
  end
end
