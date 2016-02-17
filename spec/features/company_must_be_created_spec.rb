require 'rails_helper'
require "support/login_helper"

feature 'User creates a company' do
  fixtures :all

  background do
    sign_in_with users(:new_user).email, "password"
  end

  scenario 'successfully' do
    expect(current_path).to eq(new_company_path)
    expect(page).to have_css 'h1', text: 'Welcome!'
    fill_in 'Name', with: 'Walk it off'
    fill_in 'Url', with: 'http://walkitoff.ca'
    select 'Alaska', from: 'company_time_zone'
    click_button 'Next'
    expect(current_path).to eq(dashboard_path)
  end

  scenario 're-routes to company onboarding if a company does not exist' do
    visit dashboard_path
    expect(current_path).to eq(new_company_path)
  end
end
