Factpand3::Application.routes.draw do


  #get "verreportes/index"

  resource :reportes do
    get 'facturado', :on => :collection
    get 'movimientos', :on => :collection
    get 'articulos_reporte', :on => :collection
    get 'conjunto_articulos_reporte', :on => :collection
  end

  resources :notadedebitos do
    resources :renglon_notadebitos
    resources :renglon_ndddetalles
    resources :renglon_nddndcs
    resources :renglon_ndd_articulos
    get 'filtered' , :on => :collection
    get 'proximo_preimpreso', :on => :collection
    get 'generar_impresion' , :on => :collection
    get 'anular', :on => :collection
  end

  resources :notadecreditos do
    resources :renglon_notacreditos
    resources :renglon_ndcdetalles
    resources :renglon_ndcndds
    resources :renglon_ndc_articulos
    get 'filtered' , :on => :collection
    get 'proximo_preimpreso', :on => :collection
    get 'generar_impresion' , :on => :collection
    get 'anular', :on => :collection
  end

  #resources :mails

  #get "sessions/new"

  resource :sessions, :only => [ :new, :create, :destroy]

  match '/signin', :to => 'sessions#new'

  match '/signout', :to => 'sessions#destroy'

  match '/signup', :to => 'users#new'

  resources :users

  resources :recibos do
    resources :renglon_recibos
    resources :renglon_recdetalles
    resources :renglon_recibo_docs
    get 'filtered' , :on => :collection
    get 'proximo_preimpreso', :on => :collection
    get 'generar_impresion' , :on => :collection
    get 'anular', :on => :collection
  end

  resources :facturas do
    get 'proximo_preimpreso', :on => :collection
    get 'filtered' , :on => :collection
    get 'generar_impresion' , :on => :collection
    get 'anular', :on => :collection
    resources :renglon_facturas
    resources :renglon_factdetalles
  end

  resources :listaprecios do
    get 'getPrecioArticuloCliente', :on => :collection
     get 'importarcliente', :on => :collection
    get 'copiarlista', :on => :collection
    resources :precioarts
  end

  root :to => "page#home"

  #resources :telefonos

  resources :articulocomps do
    resources :rolarticulos
    resources :comercializables do
      resources :precioarts
    end
  end

  resources :articuloinds do
    resources :rolarticulos
    resources :comercializables do
      resources :precioarts
    end
  end

  resources :tipoclientes do
    resources :mail_internos
  end

  resources :impuestos

  resources :pagocontados

  resources :pagoacreditos

  resources :monedas

  resources :formadepagos

  resources :articulos do
    resources :rolarticulos
    resources :comercializables do
      resources :precioarts
    end    
  end

  resources :promocions

  resources :sucursals

  resources :empresas do
    resources :contactos do
       resources :telefonos
       resources :mail_internos
    end
    resources :descuento_clientes
    resources :telefonos
    resources :mail_internos
    resources :sucursals do
      resources :telefonos
      resources :mail_internos
      resources :contactos do
        resources :telefonos
        resources :mail_internos
      end
    end
  end
  
  resources :sucursals do
    resources :telefonos
    resources :mail_internos
    resources :contactos do
      resources :telefonos
      resources :mail_internos
    end
  end

  resources :contactos do
    resources :telefonos
    resources :mail_internos
  end

  resources :clientes do
    resources :descuento_clientes
  end

  resources :personas do
    resources :telefonos
    resources :mail_internos
    resources :descuento_clientes
  end

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
  # match ':controller(/:action(/:id(.:format)))'
end
