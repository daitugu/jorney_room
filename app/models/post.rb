class Post < ApplicationRecord
  has_one_attached :image
   belongs_to :user
   has_many :comments, dependent: :destroy
   has_many :likes, dependent: :destroy
   has_many :bookmarks, dependent: :destroy
   has_many :attachments, dependent: :destroy
   has_many :tagmaps, dependent: :destroy
   has_many :tags,   through: :tagmaps
    validates :lodging_fee, presence: true
    validates :image, presence: true
    validates :location, presence: true
    validates :lodging_fee, presence: true
    validates :room_type, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def find_bookmark(user)
    bookmarks.find_by(user_id: user.id)
  end

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("thoughts LIKE ? OR location LIKE ? OR lodging_fee LIKE ? OR room_type LIKE ?",
                          "#{word}", "#{word}", "#{word}", "#{word}").where(:is_opened =>true)
    elsif search == "partial_match"
      @post = Post.where("thoughts LIKE ? OR location LIKE ? OR lodging_fee LIKE ? OR room_type LIKE ?",
                          "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%").where(:is_opened =>true)
    else
      @post = Post.all
    end
  end

  def create_tags(input_tags)
    input_tags.each do |tag|                     # splitで分けたtagをeach文で取得する
      new_tag = Tag.find_or_create_by(name: tag) # tagモデルに存在していれば、そのtagを使用し、なければ新規登録する
      tags << new_tag                            # 登録するtopicのtagに紐づける（中間テーブルにも反映される）
    end
  end

  def update_tags(input_tags)
    registered_tags = tags.pluck(:name) # すでに紐付けれらているタグを配列化する
    new_tags = input_tags - registered_tags # 追加されたタグ
    destroy_tags = registered_tags - input_tags # 削除されたタグ

    new_tags.each do |tag| # 新しいタグをモデルに追加
      new_tag = Tag.find_or_create_by(name: tag)
      tags << new_tag
    end

    destroy_tags.each do |tag| # 削除されたタグを中間テーブルから削除
      tag_id = Tag.find_by(name: tag)
      destroy_tagging = Tagging.find_by(tag_id: tag_id, topic_id: id)
      destroy_tagging.destroy
    end
  end

end
