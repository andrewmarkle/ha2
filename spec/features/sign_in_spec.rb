require "rails_helper"
require "support/login_helper"

feature 'user signs in' do
  fixtures :all

  scenario 'with valid email and password' do
    visit root_path
    click_link 'Sign In'
    fill_in 'user_email', with: 'user_a@example.com'
    fill_in 'user_password', with: 'password'
    click_button 'Sign in'
    user_should_be_signed_in
  end

  scenario 'with valid mixed-case email and password ' do
    sign_in_with 'user_b@example.com', 'password'
    user_should_be_signed_in
  end

  scenario 'tries with invalid password' do
    sign_in_with 'user_b@example.com', 'wrong_password'
    page_should_display_sign_in_error
  end

  scenario 'tries with invalid email' do
    sign_in_with 'unknown.email@example.com', 'password'
    page_should_display_sign_in_error
  end

private
  def user_should_be_signed_in
    expect(page).to have_text 'Signed in'
    expect(current_path).to eq(dashboard_path)
  end

  def page_should_display_sign_in_error
    expect(page).to have_text 'Invalid email or password'
  end
end
