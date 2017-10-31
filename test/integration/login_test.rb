require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "login with valid credentials" do
    user = FactoryBot.create(:user)

    login_as(user)

    assert page.has_current_path?(user_page_path(user.id))
    assert page.has_text?(user.username)
  end

  test "login with invalid credentials" do
    user = FactoryBot.build(:user)

    login_as(user)

    assert page.has_current_path?(root_path)
    assert page.has_text?('Username or password invalid')
  end

  test "logout from user" do
    user = FactoryBot.create(:user)

    login_as(user)
    click_link 'Log out'

    assert page.has_current_path?(root_path)
  end
end
