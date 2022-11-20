class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,    #パスワードの正確性を検証
         :registerable,   #ユーザー登録や編集、削除
         :recoverable,   #パスワードをリセット
         :rememberable,   #ログイン情報を保存
         :validatable    #emailのフォーマットなどのバリデーション
  
  has_many :post_images, dependent: :destroy
  #アソシエーション1:Nの１側(userモデル)にhas_manyを記載(たくさんpost_imagesがある)
  
  has_many :post_comments, dependent: :destroy
  #アソシエーション1:Nの１側(userモデル)にhas_manyを記載(たくさんpost_commentsがある)
  
  has_many :favorites, dependent: :destroy
  #アソシエーション1:Nの１側(userモデル)にhas_manyを記載(たくさんfavoritesがある)
  
  has_one_attached :profile_image
  #profile_imageという名前でActiveStorageを使って画像を持たせるために必要な記述
  
  #プロフィール画像が存在しない場合sample_author.jpgを表示するメソッド
  #中身がよくわからん(14章)
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
    # 画像サイズを指定できるようにする=>引数width,heightに数値を代入できる
  end

end