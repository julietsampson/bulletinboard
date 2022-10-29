Rottenpotatoes::Application.routes.draw do
  root to: 'pages#index'

  post 'student_login' =>'students#login', as: :student_login
  post 'new_student' =>'students#create', as: :student_create_account
  post 'organization_login' =>'organizers#login', as: :organization_login
  post 'organization_logout' =>'organizers#logout', as: :organization_logout
  post 'new_organization' =>'organizers#create', as: :organization_create_account

  resources :events
  get 'org_events' => 'events#organizer_index', as: :organizer_events
  # root :to => 'events#index'
  # get "/" => "events#index"
end
