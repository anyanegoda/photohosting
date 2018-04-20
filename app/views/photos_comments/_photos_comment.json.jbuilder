json.extract! photos_comment, :id, :body, :created_at, :updated_at
json.url photos_comment_url(photos_comment, format: :json)
