class User < ApplicationRecord

    before_validation { email.downcase! }

    validates :name, presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    has_many :pictures
    has_many :favorites, dependent: :destroy

    mount_uploader :avatar, AvatarUploader

end
