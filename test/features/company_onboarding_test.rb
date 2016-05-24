require 'test_helper'
require 'support/login_helper'

class CompanyOnboardingTest < Capybara::Rails::TestCase
  background do
    sign_in_with users(:new_user).email, 'password'
  end

  test 'redirects and forces you to create company' do
    visit dashboard_path
    assert_equal(new_company_path, current_path)
  end

  test 'succeeds when the user fills out their company information' do
    assert_selector("h1", text: "Welcome!")
    fill_in 'Company Name', with: 'Walk it off'
    fill_in 'Company Website', with: 'http://walkitoff.ca'
    fill_in 'Phone Number', with: '000-999-9938'
    click_button 'Next'

    assert_equal(dashboard_path, current_path)
  end
end
