class RelationshipController < ApplicationController
  def create
    @followed_user = User.find_by_id(params[:id])

    @relationship = Relationship.new()
    @relationship.follower_id = current_user.id
    @relationship.followed_id = @followed_user.id

    @relationship.save

    respond_to do |format|
      format.html
      format.json { render json: @followed_user.followers.count }
    end
  end

  def destroy
    @relationship = current_user
                    .following_relationships
                    .find_by_followed_id(params[:id])
    @unfollowed_user = User.find_by_id(params[:id])

    if @relationship
      @relationship.destroy
    end

    respond_to do |format|
      format.html
      format.json { render json: @unfollowed_user.followers.count }
    end
  end
end
