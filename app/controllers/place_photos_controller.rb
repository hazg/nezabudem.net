# @encoding: utf-8
class PlacePhotosController < ApplicationController
  include PlacesHelper    
  
  #add_breadcrumb @photo.place.name, obelisks_path(@photo.place) 
  before_filter :place
  # GET /photos
  # GET /photos.xml
  def index
    @photos = PlacePhoto.all
    respond_with(@photos)
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show

    @photo = PlacePhoto.find(params[:id])
    path_breadcrumbs(@photo.place)

    respond_with(@photo)
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = PlacePhoto.new({:place_id => @place.id})
    path_breadcrumbs(@place)
    respond_with(@photo)
  end

  # GET /photos/1/edit
  def edit
    @photo = PlacePhoto.find(params[:id])
    path_breadcrumbs(@photo.place)
  end

  # POST /photos
  # POST /photos.xml
  def create
    tags = []
    @photo = PlacePhoto.new(params[:place_photo])
    @photo.user = current_user
    @photo.save
    respond_with(@photo, :location => polymorphic_url([@place, @photo]))
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    @photo = PlacePhoto.find(params[:id])
    if params['remove_tags']
        @photo.tag_list.remove( params['remove_tags'].split(/,\s/) )
    end
      
    
    @photo.update_attributes(params[:place_photo])
    respond_with(@photo, :location => polymorphic_url(@place))
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo = PlacePhoto.find(params[:id])
    @photo.destroy
    respond_with(@photo)
  end


  private


    def place
      params.each do |name, value|  
        if name =~ /(.+)_id$/  
          return  @place = $1.classify.constantize.find(value)  
        end  
      end  
      nil  
    end

end
