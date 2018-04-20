class TagsController < ApplicationController
  def index
    @tags = Tag.search(params[:term])
  end
end
