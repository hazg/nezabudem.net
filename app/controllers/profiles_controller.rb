# @encoding: utf-8
class ProfilesController < ApplicationController
  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    if not params[:id] and current_user
      @profile = Profile.find(current_user)
    else
      @profile = Profile.find(params[:id])
    end
    respond_with(@profile)
  end

  def index
    add_breadcrumb('Пользователи', nil)
    Profile.paginates_per 20
    @profiles = Profile.includes([:user => [:avatar]] ).order('created_at DESC').page params[:page]
  end

  def places
    @profile = Profile.find(params[:profile_id])
    add_breadcrumb @profile.user.nick, profile_path(@profile)
    add_breadcrumb "Добавленые объекты", nil
    Place.paginates_per 50
    @places = @profile.user.places.page params[:page]
  end

  def soldiers
    @profile = Profile.find(params[:profile_id])
    add_breadcrumb @profile.user.nick, profile_path(@profile)
    add_breadcrumb "Оцифрованные имена", nil
    Soldier.paginates_per 50
    @soldiers = @profile.user.soldiers.page params[:page]

  end
  


  def photos
    @profile = Profile.find(params[:profile_id])
    add_breadcrumb @profile.user.nick, profile_path(@profile)
    add_breadcrumb "Добавленные фотографии", nil
    PlacePhoto.paginates_per 20
    @photos = @profile.user.place_photos.page params[:page]

  end

  # GET /profiles/1/edit
  def edit
    if not params[:id] and current_user
      @profile = Profile.find(current_user)
    else
      @profile = Profile.find(params[:id])
    end

    #@profile = Profile.find(params[:id])
    respond_with(@profile)
  end

  # PUT /profiles/1
    # PUT /profiles/1.xml
  def update
    @profile = current_user.profile
    avatar = params[:profile][:avatar]
    params[:profile].delete :avatar
    current_user.avatar.update_attributes(avatar)
    @profile.update_attributes(params[:profile])
    respond_with(@profile)
  end

end
