Rails.application.routes.draw do

namespace :admin do
root to: 'homes#top'
resources :users, only: [:show, :edit, :update]
resources :items, only: [:create, :destroy]
resources :tags, only: [:create, :destroy]
end
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
devise_for :users,skip: [:passwords], controllers: {
  registrations: "member/registrations",
  sessions: 'member/sessions'
}
scope module: :member do
 root to: 'homes#top'
 patch "/customers/leave" => "customers#leave", as: "leave"
 get "/users/withdraw" => "users#withdraw", as: "withdraw"
 get "/posts/draft" => "posts#draft", as: "draft"
 get "/searchs/search" => "searchs#search", as: "searchs"
 resources :bookmarks, only: [:create, :destroy]

 resources :posts, only: [:new, :create, :index, :show, :edit, :update,:destroy] do
   resources :comments, only: [:create, :destroy]
   resources :likes, only: [:create, :destroy]
 end

 resources :users, only: [:show, :edit, :update, :index]
end
end
