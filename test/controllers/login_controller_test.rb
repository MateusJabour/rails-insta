require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  tests LoginController

  test 'creates user_id on session after login' do
    user = FactoryBot.create(:user)

    post :create, params: {username: user.username, password: user.password}

    assert_equal session[:user_id], user.id
  end

  test 'deletes user_id from session after logout' do
    user = FactoryBot.create(:user)

    post :create, params: {username: user.username, password: user.password}
    post :destroy

    assert_nil session[:user_id]
  end
end
