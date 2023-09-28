class Post < ApplicationRecord
  has_one_attached :image
   belongs_to :user
   has_many :comments, dependent: :destroy
   has_many :likes, dependent: :destroy
   has_many :bookmarks, dependent: :destroy
   has_many :attachments, dependent: :destroy
   has_many :tagmaps, dependent: :destroy

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
                          "#{word}", "#{word}", "#{word}", "#{word}")
    elsif search == "partial_match"
      @post = Post.where("thoughts LIKE ? OR location LIKE ? OR lodging_fee LIKE ? OR room_type LIKE ?",
                          "%#{word}%", "%#{word}%", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end

end
