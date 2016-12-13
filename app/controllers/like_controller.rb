class LikeController < ApplicationController
  def create
    @photo = Photo.find_by_id(params[:id])
    already_liked = !(@photo.likes.find_by_user_id(current_user.id).nil?)

    if already_liked
      @like = @photo.likes.find_by_user_id(current_user.id)
      @like.destroy
      redirect_to photo_path(@photo)
    else
      @like = @photo.likes.new
      @like.user_id = current_user.id

      @like.save
      redirect_to photo_path(@photo)
    end
  end
end
