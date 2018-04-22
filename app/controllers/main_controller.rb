class MainController < ApplicationController
  def index
    @tags = Tag.search(params[:term])
    @photos = Photo.last(6)
    @posts = Post.order("created_at DESC").first(3)
  end
end
