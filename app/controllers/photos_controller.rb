class PhotosController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_photo, only: [:show, :edit, :update, :destroy, :vote]
  before_action :authorize_photo, except: [:index, :show, :new, :create, :vote]
  respond_to :js, :json, :html

  # GET /photos
  # GET /photos.json
  def index
    @sort = params[:sort]
    if (@sort)
      if @sort == "views"
        @photos = Photo.order("views DESC")
      elsif
        @sort == "likes"
          @photos = Photo.order("likes DESC")
      elsif
        @sort == "downloads"
          @photos = Photo.order("downloads DESC")
      elsif
        @sort == "date-asc"
          @photos = Photo.order("created_at ASC")
      elsif
        @sort == "date-desc"
          @photos = Photo.order("created_at DESC")
      elsif
        @sort == "all"
          @photos = Photo.order("id ASC")
      end
    render json: { photos: @photos }
    else
      @photos = Photo.order("id ASC")
    end
    @users = User.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.find(params[:id])
    abc = @photo.views += 1
    @photo.update_attribute "views", abc
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    if !current_user.liked? @photo
      @photo.liked_by current_user
    elsif current_user.liked? @photo
      @photo.unliked_by current_user
    end
  end

  private

    def authorize_photo
      authorize @photo
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:image, :views, :likes, :downloads, :image_cache, :remove_image, :remote_image_url, attachments: [], tags_attributes: [:id, :tag, :_destroy])
    end
end
