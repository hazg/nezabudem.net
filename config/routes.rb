NezabudemNet::Application.routes.draw do
  mount Forem::Engine, :at => "/forums"
  
#  resources :users do
#    resources :messages do
#      collection do
#        post :delete_selected
#      end
#    end
#  end
  
  match 'search' => 'search#results'

  resources :messages do
    collection do
      post :delete_selected
    end
  end

  #get "omniauth_callbacks/facebook"
  #get "omniauth_callbacks/vkontakte"

  root :to => "application#welcome"
  #match 'profile' => 'profiles#edit', :via => :get
  #match 'profile' => 'profiles#show', :via => :get
  resources :profiles do
    match 'soldiers' => 'profiles#soldiers', :as => :profile_soldiers
    match 'places' => 'profiles#places', :as => :profile_places
    match 'photos' => 'profiles#photos', :as => :profile_photos
  end


  match 'profiles/:id' => 'profiles#show', :as => :user_profile
  #match 'profile' => 'profiles#update', :via => :put

  match 'help' => 'application#help'
  match 'ocr_complete' => 'application#ocr_complete'
  resources :photos

  match 'soldiers/add_from_list' => 'soldiers#add_from_list', :as => :soldiers_add_from_list
  match 'soldiers/add_mass_add' => 'soldiers#mass_add', :as => :soldiers_mass_add
  resources :soldiers

  #resources :users do
  #  get "users/sign_up", :to => "registrations#new", :as => "sign_up"
  #  get "users/sign_in", :to => "devise/sessions#new", :as => "sign_in"
  #get "users/sign_out", :to => "devise/sessions#destroy", :as => 'sign_out'
  #end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin' #, :constraints => { :subdomain => 'admin' }
  mount Forem::Engine => '/forum' #, :constraints => { :subdomain => 'forum' } 
  #mount Forem::Engine, :at => "/"

  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :users, :controllers => {
    :registrations => "registrations",
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  #devise_scope :user do
  #  get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
  #end
  #devise_for :users, :controllers => { :omniauth_callbacks => "devise/omniauth_callbacks" }




  #Authproviders::Application.routes.draw do
  mount Forem::Engine, :at => "/forums"
  resources :messages do
    collection do
      post :delete_selected
    end
  end
  #  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, :only => [:index, :destroy]
  #  root :to => 'users#index'
  #end

  #resources :photos
  #resources :users
  resources :user_session
  
  resources :place_photos do
    resources :comments
  end
  
  resources :places, :obelisks do
    resources :place_photos, :as => :photos, :path => :photos #, :only => [:create, :index, :new]
    resources :place_photos
    resources :comments
  end

  #mount Scrib::Engine => "/"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  #
  match '/public/:file', :to => redirect('/public/:file')
  match "/google_geo" => GoogleGeo.action(:index)
end
