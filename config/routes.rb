GSAtravel::Application.routes.draw do
  get "import/index"
  get "import/show"
  get "import/run_hotel"
  get "import/run_airline"
  get "import/run_car_rental"
  get "import/delete_all"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}
  root "dashboard#overview"
  get "dashboard/overview"
  get "dashboard/transactions"
  get "dashboard/transactions_flight_data"
  get "dashboard/flight_vendor_data"
  get "dashboard/transactions_hotel_data"
  get "dashboard/transactions_car_rental_data"
  get "dashboard/overview_data"
  get "dashboard/budgets"
  get "dashboard/trends"
  get "dashboard/ways_to_save"
  get "dashboard/calendar_chart"

  get "dashboard/airport_api"
  get "dashboard/partials/fat"  => 'partials#fat'
  get "dashboard/partials/annotation"  => 'partials#annotation'
  get "dashboard/partials/generic"  => 'partials#generic'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
