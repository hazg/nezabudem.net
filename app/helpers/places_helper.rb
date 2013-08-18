# @encoding: utf-8
module PlacesHelper

#  def tag_cloud
#    @tags = Place.tag_counts_on(:tags)
#    tag_cloud(@tags, %w(css1 css2 css3 css4)) do |tag, css_class|
#  <%= link_to tag.name, { :action => :tag, :id => tag.name }, :class => css_class %>
#<% end %>
#  end
  def photo_thumb(photo)
    klass = (@photo and @photo == photo) ? 'active' : ''
    render :partial => 'places/photo_thumb', :locals => {:photo => photo, :klass => klass}
  end

  def path_breadcrumbs(place)
    place.ancestors.order('ancestry_depth DESC').each do |x| 
      add_breadcrumb x.name, polymorphic_path(x) 
    end
    add_breadcrumb place.name, polymorphic_path(place)
  end


end
