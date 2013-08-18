# @encoding: utf-8
require "application_responder"


class ApplicationController < ActionController::Base
  #before_filter :sape_init


  # @return [Object]
  def forem_user
    current_user
  end
  helper_method :forem_user

  include ApplicationHelper
  

  def forem_user
    current_user
  end
    
  helper_method :forem_user

  add_breadcrumb '<i class="icon-home"></i>'.html_safe, '/'
  layout proc{ |c| c.request.xhr? ? false : "application" }
  skip_authorization_check
  protect_from_forgery
  before_filter :make_breadcrumbs
  before_filter :set_locale


  self.responder = ApplicationResponder
  respond_to :html
 
  def set_locale
    I18n.locale = params[:locale] || :ru
  end

  def make_breadcrumbs
    key = "breadcrumbs.#{self.class.to_s.foreign_key.gsub(/_controller_id$/, '').singularize}.#{params[:action]}"
    begin
      text = I18n.t(key, :raise => true)
      add_breadcrumb text, request.path
    rescue
    end

    
  end
  
  def help
    add_breadcrumb I18n.t('help'), 'help'
  end
  
  def ocr_complete
    add_breadcrumb('Спасибо!', nil)
  end

  def welcome
    @featured = (Place.need_ocr | Place.need_photos)
    
    @new = Place.without_nodes.order('created_at DESC').limit(10)
    @featured = (@new | @featured).uniq
  end

  def registered
    
  end

  #def after_sign_up_path_for(resource)
  #  '/profile'
  #end
  private

  #def sape_init
  #  @sape = Sape.from_request('01823de4821c66985a3bfdfe921ee433', request)
  #end
end
