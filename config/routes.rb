Rails.application.routes.draw do
  
  get 'login' => 'sessions#new', as: 'login'
  get 'logout' => 'sessions#destroy', as: 'logout'
  post 'authenticate' => 'sessions#create', as: 'sessions'
  
  root 'index#index'
  get 'search' => 'search#results'
  
  get 'logs/add_affected_item' => 'logs#add_affected_item'
  
  resources :logs, :events, :users
  resources :items, param: :uid
  
  scope '/selection' do
    match 'select_single' => 'selections#select_single', via: [:get, :post]
    match 'deselect_single' => 'selections#deselect_single', via: [:get, :post]
    match 'select_array' => 'selections#select_array', via: [:get, :post]
    match 'deselect_array' => 'selections#deselect_array', via: [:get, :post]
    get 'clear' => 'selections#clear'
  end

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
