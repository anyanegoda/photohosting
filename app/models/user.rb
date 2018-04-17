#require 'bcrypt'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :photos, inverse_of: :user
  has_many :collections
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  mount_uploader :avatar, AvatarUploader
  mount_uploader :image, ImageUploader
end
