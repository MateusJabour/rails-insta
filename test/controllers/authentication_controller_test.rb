require 'test_helper'

class AuthenticationControllerTest < ActionController::TestCase
  tests UserController

  test 'requires authentication' do
    get :index, params: { id: FactoryGirl.create(:user).id }
    assert_redirected_to login_path
  end

  test 'render page for authenticated user' do
    user = FactoryGirl.create(:user)
    session[:user_id] = user.id

    get :index, params: { id: user.id }
    assert_response :ok
  end
end
