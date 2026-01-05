Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Mount engines
  mount UsersEngine::Engine => "/users_engine"
  mount PersonasEngine::Engine => "/personas_engine"

  # ChatEngine will be created later
  # mount ChatEngine::Engine => "/chat_engine"
end
