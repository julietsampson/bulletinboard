Rottenpotatoes::Application.routes.draw do
  root to: 'pages#index'

  post 'student_login' =>'students#login', as: :student_login
  post 'new_student' =>'students#create', as: :student_create_account
  post 'organization_login' =>'organizers#login', as: :organization_login
  post 'organization_logout' =>'organizers#logout', as: :organization_logout
  post 'new_organization' =>'organizers#create', as: :organization_create_account
  post 'student_update_path/:id' => 'students#update', as: :student_update

  resources :events
  get 'student_login_page' => 'pages#student_login', as: :student_login_page
  get 'organizer_login_page' => 'pages#organizer_login', as: :organizer_login_page
  get 'org_events' => 'events#organizer_index', as: :organizer_events
  get 'my_events' => 'students#my_events', as: :student_events
  get 'about_event/:id' => 'events#student_show', as: :about_event
  get 'add_event/:id' => 'students#add_event', as: :add_event
  get 'remove_event/:id' => 'students#remove_event', as: :remove_event
  get 'student_profile' => 'students#my_profile', as: :student_profile
  get 'show_schedule' => 'students#show_schedule', as: :show_schedule
  get 'edit_schedule' => 'students#edit_schedule', as: :edit_schedule
  post 'update_schedule' => 'students#update_schedule', as: :update_schedule
  get 'remove_timeblock/:id' => 'students#remove_timeblock', as: :remove_timeblock
  # root :to => 'events#index'
  # get "/" => "events#index"
end
