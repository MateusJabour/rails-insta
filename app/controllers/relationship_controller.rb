class RelationshipController < ApplicationController
  def create
    @user = User.find_by_id(current_user.id)
    @followed_user = User.find_by_id(params[:id])

    @relationship = Relationship.new()
    @relationship.follower_id = @user.id
    @relationship.followed_id = @followed_user.id

    @relationship.save
    redirect_to user_page_path(current_user)
  end
end
