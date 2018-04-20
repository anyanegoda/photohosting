class TagsController < ApplicationController
  def index
    @tags = Tag.search(params[:term]).order("id ASC")
    #binding.pry
  end
end
