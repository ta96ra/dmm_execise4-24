class PostImage < ApplicationRecord
  
  has_one_attached :image   #ActiveStorageを使って画像を持たせるために必要な記述
  belongs_to :user    #アソシエーション：userに属するという意味、1:NのN側の記述
  has_many :post_comments, dependent: :destroy
  #アソシエーション1:Nの１側(post_imageモデル)にhas_manyを記載(たくさんpost_commentsがある)
  has_many :favorites, dependent: :destroy
  #アソシエーション1:Nの１側(post_imageモデル)にhas_manyを記載
  
  validates :shop_name, presence:true
  #shop_nameが存在しているかを確認するバリデーション
  validates :image,presence:true
  #imageが存在しているかを確認するバリデーション
  
  #画像が存在しない場合no_image.jpgを表示するメソッド
  #中身がよくわからん(11章)
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file.path),filename:'default-image.jpg',content_type: 'image/jpeg')
    end
    image
  end
  
  # ユーザーidがfavoritesテーブル内に存在するかどうかを調べる
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
