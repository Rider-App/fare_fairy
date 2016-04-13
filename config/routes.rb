Rails.application.routes.draw do

  # get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')

  get 'fares/show', defaults: {format: 'json'}
  root 'fares#show', defaults: {format: 'json'}
  get 'homes/show'

  get 'fares/show', defaults: {format: 'json'}
  # root 'homes#show'

  post 'sessions/create'

  resources :users, except: :update
  patch 'users' => 'users#update'

  resources :favorites

  get 'api/v1/fares' => 'fares#show', defaults: {format: 'json'}
  post 'api/v1/users' => 'users#create'
  patch 'api/v1/users' => 'users#update'
  post 'api/v1/login' => 'sessions#create'
  delete 'api/v1/logout' => 'sessions#destroy'
  get 'api/v1/favorites' => 'favorites#show', defaults: {format: 'json'}
  post 'api/v1/favorites' => 'favorites#create'
  patch 'api/v1/favorites/:id' => 'favorites#update'
  delete 'api/v1/favorites/:id' => 'favorites#destroy'



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
