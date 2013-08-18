require 'open-uri'
class GoogleGeo < ActionController::Metal
  include ActionController::Rendering
  #append_view_path "#{Rails.root}/app/views"
  def index
    q = CGI.escape params[:q]
    uri = "http://maps.google.com/maps/geo?q=#{q}"
    
    open(URI.parse(uri)) do |f|
      render :text => f.readlines.join
    end
    #render :text => 'From google geo'
  end
end
