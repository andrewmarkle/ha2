require 'rails_helper'
require 'support/login_helper'

feature 'Plan scoping' do
  fixtures :all

  scenario "display's only User A's records" do
    sign_in_with 'user_a@example.com', 'password'
    visit plans_url
    expect(page).to have_content 'This plan belongs to Company A'
    expect(page).not_to have_content 'This plan belongs to Company B'
  end

  scenario "display's only user B's records" do
    sign_in_with 'user_b@example.com', 'password'
    visit plans_url
    expect(page).to have_content 'This plan belongs to Company B'
    expect(page).not_to have_content 'This plan belongs to Company A'
  end
end
