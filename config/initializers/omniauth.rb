Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  provider :facebook, '432912520082871', 'bc7d9aee33570c4662660c8d85e363d8'
  provider :vkontakte, '3021509', 'I4trKCz7TulFUldEC5pH'
    #:scope => 'friends,audio,photos', :display => 'popup'
  #provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
