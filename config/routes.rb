Filmwin::Application.routes.draw do
  resources :users
  resources :events
  resources :submissions
  resources :submission_quantities, only: [:create, :edit, :update, :destroy]
  resources :submission_costs
  resources :orders, only: [:create]
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]

  root 'static_pages#home'
  match '/submissions/:id/upload(.:format)',  to: 'submissions#upload', via: 'get', as: :upload_submission
  match '/events/:id/submissions', to: 'events#submissions', via: 'get', as: :submission_event
  match '/orders/new',  to: 'orders#create',    via: 'post', as: :create_orders
  match '/signup',      to: 'users#new',            via: 'get'
  match '/signin',      to: 'sessions#new',         via: 'get'
  match '/signout',     to: 'sessions#destroy',     via: 'delete'
  match '/help',        to: 'static_pages#help',    via: 'get'
  match '/about',       to: 'static_pages#about',   via: 'get'
  match '/contact',     to: 'static_pages#contact', via: 'get'
  match '/admin',       to: 'admin#index',          via: 'get'
  match '/admin/events/:id',   to: 'admin#events',  via: 'get', as: :admin_events
  match '/events/:event_id/submission_quantities/new', to: 'submission_quantities#new', via: 'get', as: :new_submission_quantity_event


end
