module ActionDispatch
  class IntegrationTest
    def login_as(user)
      visit root_path

      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_on 'Log in'
    end
  end
end
