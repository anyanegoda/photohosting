class PhotosCommentsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_photo
  before_action :set_photos_comment, only: [:show, :edit, :update, :destroy]
  before_action :authorize_photos_comment, only: [:edit, :update, :destroy]
  respond_to :json, only: [:create, :destroy, :update]

  def show
  end

  def edit
  end

  def create
    @photos_comment = @photo.photos_comments.create(photos_comment_params)
    render json: { comment: @photos_comment, created_at: I18n.l(@photos_comment.created_at, format: :short) }
  end

  def update
    @photos_comment.update(photos_comment_params)
    respond_with(@photo, @photos_comment)
  end

  def destroy
    @photos_comment.destroy
    respond_with(@photo, @photos_comment)
  end

  private

    def authorize_photos_comment
      authorize @photos_comment
    end

    def set_photo
      @photo = Photo.find(params[:photo_id])
    end

    def set_photos_comment
      @photos_comment = @photo.photos_comments.find(params[:id])
    end

    def photos_comment_params
      params.require(:photos_comment).permit(:body).merge(user_id: current_user.id)
    end
end
