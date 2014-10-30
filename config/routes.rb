Rails.application.routes.draw do
  post 'github_api/find'

  root to: "home#index"
end
