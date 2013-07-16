# @encoding: utf-8
module PlacesHelper

#  def tag_cloud
#    @tags = Place.tag_counts_on(:tags)
#    tag_cloud(@tags, %w(css1 css2 css3 css4)) do |tag, css_class|
#  <%= link_to tag.name, { :action => :tag, :id => tag.name }, :class => css_class %>
#<% end %>
#  end

  def path_breadcrumbs(place)
    place.path.each do |x| 
      add_breadcrumb x.address, polymorphic_path(x) 
    end
  end

  def display_autor
    link_to "автор: #{@place.user.nick}", profile_path(@place.user.profile)
  end
end