require 'rails_helper'
require "support/login_helper"

feature 'User is forced to create a company' do
  fixtures :users

  background do
    sign_in_with users(:new_user).email, "password"
  end

  scenario 'redirects and forces you to create company' do
    visit dashboard_path
    expect(current_path).to eq(new_company_path)
  end

  scenario 'succeeds when the user fills out the form' do
    expect(page).to have_css 'h1', text: 'Welcome!'
    fill_in 'Company Name', with: 'Walk it off'
    fill_in 'Company Website', with: 'http://walkitoff.ca'
    fill_in 'Phone Number', with: '000-999-9938'
    click_button 'Next'

    expect(current_path).to eq(dashboard_path)
  end
end
