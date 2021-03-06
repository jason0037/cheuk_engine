Rails.application.routes.draw do
  
  root :to=>"users#new"

  resources :roles do
    get :add_member,:on=>:member
    get :del_member,:on=>:member
    get :mlist,:on=>:member
    get :get_role,:on=>:collection
    get :user_list,:on=>:collection
    post :process_set,:on=>:collection
    get :assign,:on=>:collection
    get :company,:on=>:collection
    get :get_max_service,:on=>:collection
    get :set_max_service,:on=>:collection
    get :set_session_log,:on=>:collection
    get :del_session_log,:on=>:collection
    get :get_customer_service,:on=>:collection
  end

  resources :guests do
    get :reg_guest,:on=>:collection
    get :get_guests,:on=>:collection
    get :set_trail,:on=>:collection
    get :get_trail,:on=>:collection
    get :get_all_guests,:on=>:collection
  end

  resources :tasks do
    get :create_question,:on=>:collection
    get :get_tasks,:on=>:collection
    get :get_task_count,:on=>:collection
    get :question,:on=>:collection
    get :answer,:on=>:collection
    get :append_answer,:on=>:collection
    get :finish,:on=>:collection
  end

  resources :users do
    post :login,:on=>:collection
    get :logout,:on=>:collection
  end

  resources :customer_info_tasks do
    get :create_instance,:on=>:collection
    get :pass,:on=>:collection
    get :eventlogs,:on=>:collection
    get :process_list,:on=>:collection
    get :apply,:on=>:collection
    get :fail,:on=>:collection
    get :get_tasks,:on=>:collection
  end
  resources :roles_users
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
