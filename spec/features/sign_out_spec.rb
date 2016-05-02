require 'rails_helper'
require 'support/login_helper'

feature 'user signs out' do
  fixtures :all

  scenario 'successfully' do
    sign_in_with 'user_b@example.com', 'password'
    click_link 'Sign out'

    expect(page).to have_content 'Signed out'
    expect(current_path).to eq(root_path)
  end
end
