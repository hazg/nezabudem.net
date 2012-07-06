Forem.user_class = "User"
Forem.email_from_address = "info@nezabudem.net"
Forem.sign_in_path = "/users/sign_in"

# If you do not want to use gravatar for avatars then specify the method to use here:
Forem.avatar_user_method = 'forum_avatar'
Forem.per_page = 20
Forem.user_profile_links = true
Forem.formatter = ForemFormatter
# If you want to change the layout that Forem uses, uncomment and customize these lines:
#
Rails.application.config.to_prepare do
  Forem::ApplicationController.layout "forum"
end
#
# By default, these lines will use the layout located at app/views/layouts/forem.html.erb in your application.
