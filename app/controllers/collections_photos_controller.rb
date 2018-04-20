class CollectionsPhotosController < ApplicationController
  respond_to :json, only: [:create, :destroy, :update]

  def create
    @collections_photo = CollectionsPhoto.create(collection_photo_params)
  end

  def delete
    photo = Photo.find(params[:photo_id])
    collection = photo.collections.find(params[:collection_id])
    if collection
      photo.collections.delete(collection)
    end
  end

  private
    def collection_photo_params
      params.require(:collections_photo).permit(:collection_id, :photo_id)
    end
end
