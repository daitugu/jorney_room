Rails.application.routes.draw do

namespace :admin do
 root to: 'homes#index'
 resources :posts, only: [:show, :edit, :destroy]do

   resources :comments, only: [:create, :destroy]
end
 get "/posts/detail" => "posts#detail", as: "detail"
 get "/posts/:id/draft" => "posts#draft", as: "draft"
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
 get "/searches/search" => "searches#search", as: "searches"

 resources :bookmarks, only: [:create, :destroy] do
  collection do
   get :bookmarks_index
  end
 end
  get "/mypage" => "users#mypage"
 resources :users, only: [:show, :edit, :update, :index]
 resources :tags, only: [:create, :destroy]
 resources :posts, only: [:new, :create, :index, :show, :edit, :update,:destroy] do
   resources :comments, only: [:create, :destroy]
   resources :likes, only: [:create, :destroy]
     member do
   get :detail

  end
  collection do
   get :draft
  end
 end


end
end
