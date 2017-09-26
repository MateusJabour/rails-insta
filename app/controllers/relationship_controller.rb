class RelationshipController < ApplicationController
  def create
    @followed_user = User.find_by_id(params[:id])
    data = {}
    data[:button_action] = unfollow_user_path(@followed_user.id)

    @relationship = Relationship.new()
    @relationship.follower_id = current_user.id
    @relationship.followed_id = @followed_user.id

    if @followed_user.is_private
      data[:button_name] = 'Pending'
    else
      @relationship.accepted = true
      data[:button_name] = 'Unfollow'
    end

    if @relationship.save
      unless @followed_user.is_private
        @relationship.createNotification
      end
    end

    data[:follower_amount] = @followed_user.followers.count

    respond_to do |format|
      format.html
      format.json { render json: data }
    end
  end

  def destroy
    @unfollowed_user = User.find_by_id(params[:id])
    @relationship = Relationship.where({ followed_id: @unfollowed_user.id, follower_id: current_user.id }).first

    if @relationship
      @relationship.destroy
    end

    data = {
      button_action: follow_user_path(@unfollowed_user.id),
      button_name: 'Follow',
      follower_amount: @unfollowed_user.followers.count
    }

    respond_to do |format|
      format.html
      format.json { render json: data }
    end
  end

  def accept_relationship
    @relationship = Relationship.find_by_id(params[:relationship_id])

    if @relationship.update({ accepted: true })
      @relationship.createNotification
    end
  end

  def decline_relationship
    @relationship = Relationship.find_by_id(params[:relationship_id])
    @relationship.destroy
  end
end
