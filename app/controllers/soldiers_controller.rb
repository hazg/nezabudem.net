class SoldiersController < ApplicationController
  include PlacesHelper
  before_filter :before
  respond_to :html, :csv
  def before
    if params[:id]
      
      @soldier = Soldier.find(params[:id])
      if @soldier.place
        @place = @soldier.place
        path_breadcrumbs(@soldier.place)
        add_breadcrumb(@soldier.fio, polymorphic_path(@soldier))
      end
    end
  end


  def add_from_list
    @soldiers = []
    @soldirable_type = params[:soldiers][:soldirable_type]
    @soldirable_id = params[:soldiers][:soldirable_id]
    @place_id = params[:soldiers][:place_id]
    if params[:soldiers][:soldirable_type] == 'PlacePhoto'
      @photo = PlacePhoto.find(params[:soldiers][:soldirable_id].to_i)
      #@photo = params[:soldiers][:soldirable_id]
    end
    list = params[:soldiers].delete(:list)
    list.split(/\n/).each do |s|
      if s != "\r"
        soldier = Soldier.new(params[:soldiers].merge({:fio => s}))
        soldier.user = current_user
        soldier.save if params[:save]
        @soldiers << soldier
      end
    end
    
    if @photo and params[:save]
      @photo.need_ocr = false
      @photo.save
      
      n = @photo.place.photos.need_ocr
      n = PlacePhoto.need_ocr if n.count < 1
      n = false if n.count < 1
      if n and 
        
        next_path =  polymorphic_path([n.first.place, n.first])
        redirect_to(next_path)
      else
        redirect_to ocr_complete_path
      end
    end
    
  end

  
  # GET /soldiers
  # GET /soldiers.xml
  def index
    @soldiers = Soldier.all
    respond_with(@soldiers)
  end

  # GET /soldiers/1
  # GET /soldiers/1.xml
  def show
    respond_with(@soldier)
  end

  # GET /soldiers/new
  # GET /soldiers/new.xml
  def new
    @soldier = Soldier.new
    respond_with(@soldier)
  end

  # GET /soldiers/1/edit
  def edit
  end

  # POST /soldiers
  # POST /soldiers.xml
  def create
    @soldier = Soldier.new(params[:soldier])
    @soldier.user = current_user
    @soldier.save
    respond_with(@soldier)
  end

  # PUT /soldiers/1
  # PUT /soldiers/1.xml
  def update
    @soldier.update_attributes(params[:soldier])
    respond_with(@soldier)
  end

  # DELETE /soldiers/1
  # DELETE /soldiers/1.xml
  def destroy
    @soldier.destroy
    respond_with(@soldier)
  end
end
