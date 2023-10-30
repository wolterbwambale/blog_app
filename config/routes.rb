Rails.application.routes.draw do
  resource :users, only: [:index, :show] do
    resource :posts, only: [:index, :show]
  end
end
