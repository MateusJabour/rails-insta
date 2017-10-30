class PhotoController < ApplicationController
  before_action :require_login

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

  def like
    @photo = Photo.find_by_id(params[:id])
    already_liked = !(@photo.likes.find_by_user_id(current_user.id).nil?)

    if already_liked
      @like = @photo.likes.find_by_user_id(current_user.id)
      @like.destroy
    else
      @like = @photo.likes.new
      @like.user_id = current_user.id

      if @like.save
        @like.createNotification
      end
    end

    respond_to do |format|
      format.html
      format.json { render json: @photo.likes.count }
    end
  end

  def comment
    @photo = Photo.find_by_id(params[:id])
    @comment = @photo.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      @comment.createNotification
    else
      flash.now.alert = 'Invalid comment'
    end

    respond_to do |format|
      format.html
      format.json { render json: { comment: @comment, username: @comment.user.username } }
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:description, :image)
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
