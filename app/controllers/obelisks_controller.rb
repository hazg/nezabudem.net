# @encoding: utf-8
class ObelisksController < ApplicationController
  load_and_authorize_resource :place
  include PlacesHelper
  add_breadcrumb "Обелиски", :obelisks_path
  #before_filter :process_soldiers

  # GET /places
  # GET /places.xml
  def index
    Obelisk.paginates_per 10
    @places = Obelisk.without_nodes.order('updated_at DESC').page params[:page]
    respond_with(@places)
  end
  
  # GET /places/1
  # GET /places/1.xml
  def show
    Obelisk.paginates_per 10
    @place = Obelisk.find(params[:id])
    @places = @place.subtree.without_nodes.order('updated_at DESC').page params[:page]
    path_breadcrumbs(@place)
    respond_with(@place)
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Obelisk.new
    respond_with(@place)
  end

  # GET /places/1/edit
  def edit
    @place = Obelisk.find(params[:id])
    path_breadcrumbs(@place)
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Obelisk.new(params[:obelisk])
    #process_soldiers
    @place.user = current_user
    #@place.build_address_ancestry()
    @place.save
    respond_with(@place)
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Obelisk.find(params[:id])
    #process_soldiers
    @place.update_attributes(params[:obelisk])
    respond_with(@place)
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Obelisk.find(params[:id])
    @place.destroy
    respond_with(@place)
  end

  
end
