class PhotoController < ApplicationController
  def index
    @photo = Photo.find_by_id(params[:id])
    @like = Like.new
  end

  def new
    @photo = Photo.new
  end

  def create
    photo = current_user.photos.new(photo_params)
    if photo.save
      redirect_to user_page_path(current_user), notice: 'Photo posted'
    else
      flash.now.alert = photo.errors.full_message
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:description, :image)
  end
end
