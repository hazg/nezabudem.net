class PlacesController < ApplicationController
  layout false
  include ActsAsTaggableOn::TagsHelper
  #caches_page :index

  respond_to :json, :html
  # GET /places
  # GET /places.xml
  def index
    if params[:x1]
      @places = Place.by_bounds( params[:x1], params[:y1], params[:x2], params[:y2], params )
    end
    #@places = Place.without_nodes
    respond_with(@places)
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])
    respond_with(@place)
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new
    respond_with(@place)
  end
  
  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create
  #  expire_page :action => :index
    @place = Place.new(params[:place])
    @place.save
    respond_with(@place)
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
  #  expire_page :action => :index
    @place = Place.find(params[:id])
    @place.update_attributes(params[:place])
    respond_with(@place)
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
  #  expire_page :action => :index
    @place = Place.find(params[:id])
    @place.destroy
    respond_with(@place)
  end
end
