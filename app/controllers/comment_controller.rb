class CommentController < ApplicationController
  def create
    @photo = Photo.find_by_id(params[:id])
    @comment = @photo.comments.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to photo_path(@photo)
    else
      redirect_to photo_path(@photo), notice: 'Comment can\'t be blank'
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
