Rottenpotatoes::Application.routes.draw do
  root to: 'pages#index'
  post 'student_login' =>'students#login', as: :student_login
  post 'new_student' =>'students#create', as: :student_create_account
  post 'organization_login' =>'organizers#login', as: :organization_login
  post 'new_organization' =>'organizers#create', as: :organization_create_account
  get 'events' => 'events#index', as: :events
  get 'create_event' => 'events#new', as: :new_event
  post 'submit_event' => 'organizers#create_event', as: :submit_event
  get 'org_events' => 'events#organizer_index', as: :organizer_events
  get 'my_events' => 'students#my_events', as: :student_events
  get 'about_event/:id' => 'events#show', as: :about_event
  get 'add_event/:id' => 'students#add_event', as: :add_event
  get 'remove_event/:id' => 'students#remove_event', as: :remove_event
  # root :to => 'events#index'
  # get "/" => "events#index"
end
