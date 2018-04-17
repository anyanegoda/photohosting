class Post < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  has_many :comments, dependent: :destroy
end
