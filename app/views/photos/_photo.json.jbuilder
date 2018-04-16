json.extract! photo, :id, :image, :views, :likes, :downloads, :tags, :created_at, :updated_at
json.url image(photo, format: :json)
