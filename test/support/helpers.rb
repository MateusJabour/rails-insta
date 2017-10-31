module ActionDispatch
  class IntegrationTest
    def login_as(user)
      visit root_path

      fill_in 'Username', with: user.username
      fill_in 'Password', with: user.password
      click_on 'Log in'
      wait_for_ajax
    end

    def wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    def finished_all_ajax_requests?
      page.evaluate_script('jQuery.active').zero?
    end
  end
end
