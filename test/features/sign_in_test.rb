require 'test_helper'
require 'support/login_helper'

class UserSignInTest < Capybara::Rails::TestCase
  test 'with valid email and password' do
    visit root_path
    click_link 'Sign In'
    fill_in 'user_email', with: 'user_a@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Sign in'
    user_should_be_signed_in
  end

  test 'with valid mixed-case email and password ' do
    sign_in_with 'user_b@example.com', 'password'
    user_should_be_signed_in
  end

  test 'tries with invalid password' do
    sign_in_with 'user_b@example.com', 'wrong_password'
    page_should_display_sign_in_error
  end

  test 'tries with invalid email' do
    sign_in_with 'unknown.email@example.com', 'password'
    page_should_display_sign_in_error
  end

private

  def user_should_be_signed_in
    page.must_have_content 'Signed in'
    assert_equal(dashboard_path, current_path)
  end

  def page_should_display_sign_in_error
    page.must_have_content 'Invalid email or password'
  end
end
