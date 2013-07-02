Ftc::Application.routes.draw do
  resources :profiles

  resources :votes

  resources :trades do
    resources :comments
    get :autocomplete_player_name, :on => :collection
    get :search, :on => :collection
  end

  resources :players do 
    member do
      get ":slug" => "players#show"
    end
  end

  resources :teams do
    member do
      get ":slug" => "teams#show"
    end
  end

  resources :leagues

  devise_for :users

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  root :to => "welcome#index"
  match 'home' => 'welcome#index'
  match '/trades/new/:league' => 'trades#new'
  match '/trades/browse/:sort/:league' => 'trades#index'
  match '/trades/search/' => 'trades#search'
  match '/trades/new' => 'trades#select_league'
  match '/trades/league/select' => 'trades#select_league', :as => "league_select"
  match '/about' => 'pages#show', :id => 'about'
  match '/advertise' => 'pages#show', :id => 'advertise'
  match '/contact' => 'welcome#contact_form'
  match '/contact/send' => 'welcome#send_contact_form'
  resource :usernames
  
  match 'robot/absorb_nfl' => "robot#absorb_nfl"
  match 'robot/nfl_players_to_s3' => 'robot#nfl_players_to_s3'
  match 'robot/fix_missing_nfl_images' => 'robot#fix_missing_nfl_images'
  match 'robot/clear_nfl_cache' => 'robot#clear_nfl_cache'
  
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    get "/register" => "devise/registrations#new"
    get "/users/confirm/:confirmation_token" => 'devise/confirmations#show'
    get "/usernames/new" => "usernames#new"
    post "/usernames" => "usernames#edit"
    get "/usernames/edit" => "usernames#edit"
    post "/usernames/edit" => "usernames#edit"
    get "/users/password/change" => "devise/registrations#edit" 
    get "/avatars/upload" => "profiles#edit"
    post "/trades/vote/:id.:format" => "trades#update"
    get "/users/:id" => "profiles#show"
    get "/users/:id/:username" => "profiles#show"
  end
  

end
