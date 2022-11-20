class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @post_images = @user.post_images
    # ⬆︎特定ユーザー(@user)に関連付けられた投稿全て(post_images)を取得
    @post_images = @user.post_images.page(params[:page])
    # ⬆︎特定ユーザー(@user)に関連付けられた投稿１ページ分を取得(kaminariメソッド)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)   #あっているかわからん
    redirect_to user_path(@user.id)   #あっているかわからん
  end
  
  # ストロングパラメーター
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end