# @encoding: utf-8
class ObelisksController < ApplicationController
  

  #load_and_authorize_resource :place if params[:id]
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
    authorize! :show, @place
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
    authorize! :edit, @place
    path_breadcrumbs(@place)
  end

  # POST /places
  # POST /places.xml
  def create
  #  expire_action :action => [:index, :show]

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
  #  expire_action :action => [:index, :show]
    @place = Obelisk.find(params[:id])
    authorize! :update, @place
    #process_soldiers
    @place.update_attributes(params[:obelisk])
    respond_with(@place)
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
  #  expire_action :action => [:index, :show]
    @place = Obelisk.find(params[:id])
    authorize! :destroy, @place
    @place.destroy
    respond_with(@place)
  end

  
end
