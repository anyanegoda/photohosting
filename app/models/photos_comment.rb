class PhotosComment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :photo
  validates :body, presence: true
end
