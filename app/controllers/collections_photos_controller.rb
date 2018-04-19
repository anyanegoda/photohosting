class CollectionsPhotosController < ApplicationController
  respond_to :json, only: [:create, :destroy, :update]

  def create
    @collections_photo = CollectionsPhoto.create(collection_photo_params)
  end

  def delete
  end

  private
    def collection_photo_params
      params.require(:collections_photo).permit(:collection_id, :photo_id)
    end
end
