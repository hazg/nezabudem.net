class RegistrationsController < Devise::RegistrationsController
  
  protected

  def after_sign_up_path_for(resource)
    "/profiles/#{current_user.profile.id}/edit" if current_user
  end
end
