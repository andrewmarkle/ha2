require 'rails_helper'
require 'support/login_helper'

feature "a Company's tax settings" do
  fixtures :all

  background do
    sign_in_with 'user_a@example.com', 'password'
  end

  scenario 'is created' do
    click_link 'PLANS'
    click_link 'Taxes'
    fill_in 'Name', with: 'HST'
    fill_in 'Rate', with: '13'
    click_button 'Create Tax'
  end

  scenario 'are only shown in the plan if taxes have been set up' do
    click_link 'PLANS'
    click_link 'Add New Plan'
    expect(page).not_to have_text('Add tax?')
  end
end
