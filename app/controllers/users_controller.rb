class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]

  def show
    @user = User.find(params[:id])
    @sort = params[:sort]
    if (@sort)
      if @sort == "views"
        @photos = @user.photos.order("views DESC")
      elsif
        @sort == "likes"
          @photos = @user.photos.order("likes DESC")
      elsif
        @sort == "downloads"
          @photos = @user.photos.order("downloads DESC")
      elsif
        @sort == "date-asc"
          @photos = @user.photos.order("created_at ASC")
      elsif
        @sort == "date-desc"
          @photos = @user.photos.order("created_at DESC")
      elsif
        @sort == "all"
          @photos = @user.photos.order("id ASC")
      end
    render json: { photos: @photos }
    else
      @photos = @user.photos.all
    end
  end

  def index
    @users = User.all
  end

  def update
    #@user.update(user_params)
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    flash[:success] = 'OK!'
    redirect_to root_path
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
  end

end
