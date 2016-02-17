require "rails_helper"
require "support/login_helper"

feature 'user signs out' do

  scenario 'successfully' do
    sign_in_with 'user_b@example.com', 'password'
    click_link 'Sign out'

    expect(current_path).to eq(root_path)
    expect(page).to have_content 'Signed out'
  end
end
