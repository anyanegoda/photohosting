class MainController < ApplicationController
  def index
    @tags = Tag.search(params[:term])
    @photos = Photo.last(6)
    @posts = Post.last(3)
  end
end
