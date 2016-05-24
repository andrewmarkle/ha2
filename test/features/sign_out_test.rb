require 'test_helper'
require 'support/login_helper'

class UserSignOutTest < Capybara::Rails::TestCase
   test 'user signs out successfully' do
    sign_in_with 'user_b@example.com', 'password'
    click_link 'Sign out'

    page.must_have_content 'Signed out'
    assert_equal(root_path, current_path)
  end
end
