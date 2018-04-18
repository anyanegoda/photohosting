class Photo < ApplicationRecord
  acts_as_votable
  mount_uploader :image, ImageUploader
  mount_uploaders :attachments, ImageUploader
  validates :image, file_size: { less_than: 10.megabytes }
  has_many :tags, inverse_of: :photo
  belongs_to :user, optional: true
  has_and_belongs_to_many :collections
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
  #paginates_per 6
end
