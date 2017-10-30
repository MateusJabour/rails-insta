require 'test_helper'

class RelationshipTest < ActionDispatch::IntegrationTest
  test "following a not private user" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:user)

    login_as(user1)
    visit user_page_path(user2)

    click_on 'Follow'

    assert page.has_current_path?(user_page_path(user2))
    assert page.has_button?('Unfollow')
  end

  test "unfollow a user" do
    relationship = FactoryBot.create(:relationship)

    login_as(relationship.follower)
    visit user_page_path(relationship.followed)

    click_on 'Unfollow'

    assert page.has_current_path?(user_page_path(relationship.followed))
    assert page.has_button?('Follow')
  end

  test "following a private user" do
    user1 = FactoryBot.create(:user)
    user2 = FactoryBot.create(:private_user)

    login_as(user1)
    visit user_page_path(user2)

    click_on 'Follow'

    assert page.has_current_path?(user_page_path(user2))
    assert page.has_button?('Pending')
  end

  test "accepting a follow invite" do
    relationship = FactoryBot.create(:pending_relationship)

    login_as(relationship.followed)
    visit user_page_path(relationship.follower)

    assert page.has_link?('Accept')
    assert page.has_link?('Decline')

    click_on 'Accept'

    assert page.has_current_path?(user_page_path(relationship.follower))
    assert page.has_no_link?('Accept')
    assert page.has_no_link?('Decline')
  end
end
