Rails.application.routes.draw do

  root to: 'home#index'
  # devise_for :users, path: 'account', controllers: {
  #     sessions: 'users/sessions', registrations: 'users/registrations',
  #     confirmations: 'users/confirmations',
  #     passwords: 'users/passwords'
  # } #, path_names: {sign_in: 'login'}
  devise_for :users, skip: [:sessions], controllers: { cas_sessions: 'our_cas_sessions' }
  devise_scope :user do
    get "sign_in", to: "devise/cas_sessions#new"
    delete "sign_out", to: "devise/cas_sessions#destroy"
  end
  mount RuCaptcha::Engine => '/rucaptcha'
  resources :accounts, only: [:new, :create, :destroy] do
    collection do
      get :register
      post :register_post
      post :validate_captcha
      get :forget_password
      get :reset_password
      post :reset_password_post
      post :send_code
      post :register_email_exists
      post :register_mobile_exists
      post :register_nickname_exists
    end
  end
  get '/demeanor' => 'demeanor#index'
  get '/demeanor/videos' => 'demeanor#videos'
  get '/demeanor/get_comps_via_year' => 'demeanor#get_comps_via_year'
  get '/demeanor/:id' => 'demeanor#show'
  get 'courses/index'
  get 'courses/apply_show' => 'courses#apply_show'
  post 'courses/apply' => 'courses#apply'
  post 'courses/cancel' => 'courses#cancel_apply'
  resources :courses
  resources :competitions, only: [:index, :show] do
    collection do
      get :apply_event
      post :already_apply
      post :update_user_info
      post :leader_create_team
      get :search_team
      get :search_user
      post :apply_join_team
      post :leader_invite_player
      post :leader_delete_team
      post :leader_delete_player
      post :player_agree_leader_invite
      post :leader_deal_player_apply
      post :leader_submit_team
      post :school_submit_team
      post :district_submit_team
      post :school_refuse_teams
      post :district_refuse_teams
    end
  end
  get '/competitions/:id/events', to: 'competitions#events'
  resources :notifications
  namespace :kindeditor do
    post '/upload' => 'assets#create'
    get '/filemanager' => 'assets#list'
  end
  resources :course_score_attrs
  resources :course_files
  get '/test' => 'test#index'

  # -----------------------------------------------------------
  # Admin
  # -----------------------------------------------------------

  get '/admin/' => 'admin#index'

  namespace :admin do |admin|

    resources :accounts, only: [:new, :index, :create, :destroy] do
      collection do
        get :change_password
        post :change_password_post
      end
    end

    resources :admins
    resources :users
    resources :organizers
    resources :schedules
    resources :roles
    resources :districts
    resources :courses
    get '/courses/apply_info/:id' => 'courses#apply_info'


    resources :competitions do
      collection do
        get :get_events
        post :add_event_worker
        post :delete_event_worker
      end
    end
    # get '/competitions/events/:id' => 'competitions#events'
    # get '/competitions/workers/:id' => 'competitions#workers'
    get '/checks/teachers' => 'checks#teachers'
    get '/checks/teacher_list' => 'checks#teacher_list'
    get '/checks/hackers' => 'checks#hackers'
    get '/checks/hacker_list' => 'checks#hacker_list'
    # get '/checks/referee_list' => 'checks#referee_list'
    # get '/checks/referees' => 'checks#referees'
    get '/checks/schools' => 'checks#schools'
    get '/checks/school_list' => 'checks#school_list'
    # get '/checks/points' => 'checks#points'
    # get '/checks/point_list' => 'checks#point_list'
    # post '/checks/audit_point' => 'checks#audit_point'
    post '/checks/review_teacher' => 'checks#review_teacher'
    post '/checks/review_hacker' => 'checks#review_hacker'
    # post '/checks/review_referee' => 'checks#review_referee'
    post '/checks/review_school' => 'checks#review_school'
    #
    resources :competition_schedules do
      collection do
        post :update_cs
      end
    end
    resources :events do
      collection do
        get :teams
        get :scores
        get :add_score
        post :add_score
        get :edit_score
        post :edit_score
        post :create_team
        post :add_team_player
        post :delete_team_player
        post :delete_team
        post :add_score_attributes
        post :delete_score_attribute
        post :edit_event_sa_desc
      end
    end
    resources :event_schedules
    resources :news
    resources :activities
    resources :news_types
    resources :volunteers
    resources :score_attributes
    resources :photos #, only: [:new, :create, :index,:show]
    resources :videos
    resources :consults
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  get 'user' => redirect('/user/preview')
  get '/:id', to: 'user#index'
  get '/:id/courses', to: 'user#courses'

  match 'user/preview' => 'user#preview', as: 'user_preview', via: [:get, :post]
  get 'user/preview/:id' => 'user#preview'
  match 'user/profile' => 'user#profile', as: 'user_profile', via: [:get, :post]
  match 'user/family_hacker' => 'user#family_hacker', as: 'user_family_hacker', via: [:get, :post]
  match 'user/update_avatar' => 'user#update_avatar', as: 'user_update_avatar', via: [:post]
  match 'user/remove_avatar' => 'user#remove_avatar', as: 'user_remove_avatar', via: [:post]
  match 'user/passwd' => 'user#passwd', as: 'user_passwd', via: [:get, :post]
  match 'user/mobile' => 'user#mobile', as: 'user_mobile', via: [:get, :post]
  match 'user/email' => 'user#email', as: 'user_email', via: [:get, :post]
  match 'user/reset_mobile' => 'user#reset_mobile', as: 'user_reset_mobile', via: [:get, :post]
  match 'user/reset_email' => 'user#reset_email', as: 'user_reset_email', via: [:get, :post]
  match 'user/send_email_code' => 'user#send_email_code', as: 'user_send_email_code', via: [:post]
  match 'user/send_add_mobile_code' => 'user#send_add_mobile_code', as: 'user_send_add_mobile_code', via: [:post]
  match 'user/comp' => 'user#comp', as: 'user_comp', via: [:get]
  match 'user/consult' => 'user#consult', as: 'user_consult', via: [:get, :post]
  match 'user/point' => 'user#point', as: 'user_point', via: [:get, :post]
  match 'user/add_point' => 'user#add_point', as: 'user_add_point', via: [:get, :post]
  match 'user/notification' => 'user#notification', as: 'user_notification', via: [:get]
  get '/user/notify' => 'user#notify_show'
  match '/user/add_school' => 'user#add_school', as: 'user_add_school', via: [:post]
  match '/user/apply' => 'user#apply', as: 'user_apply', via: [:get]
  match '/user/cancel_apply' => 'user#cancel_apply', as: 'user_cancel_apply', via: [:post, :get]
  get '/user/get_schools' => 'user#get_schools', as: 'user_get_schools'
  get '/user/get_districts' => 'user#get_districts', as: 'user_get_districts'
  get '/user/get_events' => 'user#get_events', as: 'user_get_events'
  match '/user/programs' => 'user#programs', as: 'user_programs', via: [:get]
  match '/user/programs/:id' => 'user#program', via: [:get]
  post 'user/course_score' => 'user#course_score', as: 'user_course_score'
  match 'user/create_program' => 'user#create_program', as: 'user_create_program', via: [:get, :post]
  match 'user/program_se/:id' => 'user#program_se', as: 'user_program_se', via: [:get, :post]
  match 'user/course_ware/:id' => 'user#course_ware', as: 'user_course_ware', via: [:get, :post]
  get 'user/student_manage' => 'user#student_manage', as: 'user_student_manage'
  get 'user/comp_student' => 'user#comp_student', as: 'user_comp_student'
  # mount ActionCable.server => '/cable'
  match '*path', via: :all, to: 'home#error_404'
end
