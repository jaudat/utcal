Utcal::Application.routes.draw do

  root to: 'static_pages#home'

  match '/signup',  to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/help',    to: 'static_pages#help'
  match '/error',    to: 'static_pages#error', as: 'errors'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/assignments/studinfo', to: 'assignments#studinfo'
  match '/courses/builddb', to: 'courses#builddb'
  match '/admin/buildstudents', to: 'admin#buildstudents'
  match '/admin/buildcourses', to: 'admin#buildcourses'
  match '/admin/dashboard', to: 'admin#dashboard'
  match '/admin/buildprof', to: 'admin#buildprof' 

  get "/users/mycourselist" => "users#mycourselist"
  get "/users/mystudents_courses/:id", :to => "users#mystudents_courses", :as => "users_mystudents_courses"
  get "/users/mystudents/:id" => "courses#mystudents"
  get "/user/:id" => "professors#display"
  get "/user/:id" => "professors#buildDB"  #THIS IS FOR POPULATING COURSE TABLE
  get "/user/:id" => "courses#enrolledincourse" 
  # get "/user/mystudents_courses/:id" => "user#courseasgns"
  get "/users/:id" => "professors#show" 
  get "/users/add/:id" => "professors#add_students"
  get "/assignments/courseasgns/:id" => "assignments#courseasgns" 


  
  post "/users/add/:id/mail_students" => "professors#mail_students"

  resources :admin

  resources :students

  resources :professors

  resources :courses

  resources :users

  resources :assignments

  resources :sessions, only: [:new, :create, :destroy]

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
end
