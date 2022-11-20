class ApplicationController < ActionController::Base
  
  #ログインしていない状態でトップページ以外にアクセスされた場合、ログイン画面へリダイレクト
  before_action :authenticate_user!, except: [:top]
  # before_actionはコントローラが動作する前に実行される
  # authenticate_userメソッドはdevise側が用意しているメソッドで
  # ログイン認証されていなければ、ログイン画面へリダイレクトする機能
  
  # deviceのストロングパラメーター
  before_action :configure_permitted_parameters, if: :devise_controller?
  # devise利用の機能が使われる前に下のメソッドが実行される。
  
  
  # Deviseが用意しているメソッドでサインイン後にどこに遷移するか設定
  def after_sign_in_path_for(resource)
    post_images_path
    # 初期設定ではroot_pathになっている
    # ログイン後遷移作を投稿画像一覧画面にする
  end
  
  # サインアウト後にどこに遷移するか設定
  def after_sign_out_path_for(resource)
    about_path
     # 初期設定ではroot_pathになっている
  end  
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # ユーザー登録の際にユーザー名のデータ操作を許可するもの
  end  
end
