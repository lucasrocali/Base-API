Rails.application.routes.draw do
  devise_for :admin_users, ::ActiveAdmin::Devise.config
  ::ActiveAdmin.routes(self)

  # scope module: :v2, constraints: ApiVersion.new('v2') do

  # end
  
  scope module: :v1, constraints: ApiVersion.new('v1', true) do

  end

  post 'auth/login', to: 'v1/authentication#authenticate'
  post 'signup', to: 'v1/users#signup'
end
