Rails.application.routes.draw do
scope module: :member do
 root to: 'homes#top'
 resources :users, only: [:show, :edit, :update, :index]
end
namespace :admin do


end
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
devise_for :users,skip: [:passwords], controllers: {
  registrations: "member/registrations",
  sessions: 'member/sessions'
}


end