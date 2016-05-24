require 'test_helper'
require 'support/login_helper'

class TaxesCrudTest < Capybara::Rails::TestCase
  background do
    sign_in_with 'user_a@example.com', 'password'
  end

  test 'a user creates her taxes' do
    click_link 'PLANS'
    click_link 'Taxes'
    fill_in 'Name', with: 'HST'
    fill_in 'Rate', with: '13'
    click_button 'Create Tax'
    page.must_have_content("Tax was successfully created")
    assert_equal(tax_path(Tax.last), current_path)
  end

  test 'taxes are only shown in the plan if taxes have been set up' do
    click_link 'PLANS'
    click_link 'Add New Plan'
    page.wont_have_content('Add tax?')
  end
end
