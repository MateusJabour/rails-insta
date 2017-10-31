require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test "signup with valid data" do
    user = FactoryBot.build(:user)

    visit root_path
    click_link 'Sign up'

    fill_in 'Username', with: user.username
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password

    click_on 'Sign up'
    wait_for_ajax

    assert page.has_current_path?(user_page_path(User.last))
    assert page.has_text?(user.username)
  end

  test "signup with invalid data" do
    visit root_path
    click_link 'Sign up'

    click_on 'Sign up'
    wait_for_ajax

    assert page.has_current_path?(signup_path)
    assert page.has_text?("can't be blank")
  end

  %w[
    a@a
    a@a.a
    a..a@example.com
    a__a@example.com
    a.-a@example.com
    a_-a@example.com
  ].each do |email|
    test "signup with invalid data (#{email})" do
      visit root_path
      click_link 'Sign up'

      fill_in 'Email', with: email
      click_on 'Sign up'
      wait_for_ajax

      assert page.has_current_path?(signup_path)
      assert page.has_text?("Email is not valid")
    end
  end
end
