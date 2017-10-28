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

    assert page.has_current_path?(login_path)
    assert page.has_text?('Username or password invalid')
  end
end
