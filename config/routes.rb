Atlantis::Application.routes.draw do


  resources :meetings

  resources :placements

  # Theme Routes
  themes_for_rails

  get "change_log/index"

  # Root Routes
  root :to => 'dashboard#notes'
  resources :dashboard, :only => [:index, :xdocs]
  resource :change_log, :only => [:index]

  # Devise Routes
  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
  end

  # App Resources

  resources :notes, :only => :index

  resources :vteams do
    resources :opportunities
    resources :resource_vteam_allocations
    resources :vacations
    resources :notes
  end

  resources :leads do
    resources :opportunities
    resources :notes
  end
  resources :opportunities do
    resources :notes
  end
  resources :companies do
    resources :notes
  end
  resources :contacts do
    resources :notes
  end
  resources :placements do
    resources :notes
  end
  resources :meetings do
    resources :notes
  end


  resources :contacts, :companies, :opportunities, :testings, :resources

  match 'vteams/:id/resource_vteam_allocations/:rid/release' => "resource_vteam_allocations#release"
  match 'leads/details/:id' => "leads#details"
  match 'vteams/details/:id' => "vteams#details"
  match 'opportunities/details/:id' => "opportunities#details"
  match 'leads/details/:id' => "leads#details"
  match 'leads/:id/add_docs' => 'leads#add_docs'
  match 'placements/details/:id' => "placements#details"
  match 'vteams/:id/vacations/details/:rid' => "vacations#details"
  match 'meetings/details/:id' => "meetings#details"
  match 'vteams/:id/resource_vteam_allocations/details/:rid' => "resource_vteam_allocations#details"

  namespace :admin do
    match 'plugins' => 'plugins#index'
    match 'plugins/activate_plugin/:pid' => 'plugins#activate_plugin', :as=>:activate_plugin
    match 'plugins/deactivate_plugin/:pid' => 'plugins#deactivate_plugin', :as=>:deactivate_plugin

    match 'authorizations' => 'authorization#index'
    match 'authorizations/set_permissions/:action_to_do/:mode/:pid' => 'authorization#set_permissions'

    resources :users

    resources :meeting_types do
      as_routes
    end

    resources :address_types do
      as_routes
    end
    resources :contact_types do
      as_routes
    end
    resources :contact_directories do
      as_routes
    end
    resources :contact_statuses do
      as_routes
    end
    resources :phone_types do
      as_routes
    end
    resources :email_types do
      as_routes
    end
    resources :website_types do
      as_routes
    end
    resources :messenger_types do
      as_routes
    end
    resources :messenger_services do
      as_routes
    end
    resources :industries do
      as_routes
    end
    resources :countries do
      as_routes
    end
    resources :lead_types do
      as_routes
    end
    resources :lead_statuses do
      as_routes
    end
    resources :lead_sources do
      as_routes
    end
    resources :opportunity_types do
      as_routes
    end
    resources :opportunity_statuses do
      as_routes
    end
    resources :vteam_statuses do
      as_routes
    end
    resources :dev_centers do
      as_routes
    end
    resources :billing_modes do
      as_routes
    end
    resources :flags do
      as_routes
    end

    resources :note_types do
      as_routes
    end

    resources :add_users do
      as_routes
    end

    resources :resource_types do
      as_routes
    end

    resources :vacation_types do
      as_routes
    end

    resources :resource_billing_types do
      as_routes
    end

    resources :resources do
      as_routes
    end


    root :to => 'address_types#index'
  end
  match ':controller/:action'

  #  match '*a', :to => 'errors#routing'
  #  unless ActionController::Base.consider_all_requests_local
  #  end
  #resources :leads, :only => [:data_loader_status], :as => "autocomplete"
  #  resources :datagrid, :only => [:init] do
  #     collection do
  #       post "post_data"
  #     end
  #   end

  # The priority is based upon notes of creation:
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

end
