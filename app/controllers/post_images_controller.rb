class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end
  
  def create
    @post_image = PostImage.new(post_image_params)   #formに入力されたデータを格納
    @post_image.user_id = current_user.id
    #current_user:ログイン中のユーザーの情報を取得。これをuse_idカラムに代入(devise)
    if @post_image.save   #imageとshop_nameにデータが保存されていた場合
      redirect_to post_images_path
    else
      render :new   # new.htmlを再表示
    end
  end  

  def index
    # @post_images = PostImage.all
    @post_images = PostImage.page(params[:page])
    # 全てではなく１ページ分を表示(kaminariで使用できるメソッド)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    # コメントを投稿するためのインスタンスを
  end
  
  def destroy
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path   #あってるか
  end  
  
  # 投稿データのストロングパラメーター
  private
  
  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
