Rails.application.routes.draw do
 
  devise_for :users
  root to: "homes#top"   #root to:はサイトのルートページ（初めのページ）を決める記述
  
  get '/homes/about' => 'homes#about',as:'about'
  
  resources :post_images, only:[:new, :create, :index, :show, :destroy] do
    resource :favorites, only: [:create, :destroy]
    # １つのコメントに対し１回だけいいねできるため単数形
    resources :post_comments, only: [:create, :destroy]
    # 1つのコメントに対し何回も投稿できるため
  end  
  resources :users, only:[:show, :edit, :update]
  #onlyオプションにより、生成するルーティングを限定
  #ルーティングを[ ]内のアクションに限定する
  
   # get 'homes/top'
  
  # get 'post_images/new'
  # get 'post_images/index'
  # get 'post_images/show'
  
  # get 'users/show'
  # get 'users/edit'
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
