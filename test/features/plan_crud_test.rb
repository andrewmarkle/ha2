require 'test_helper'
require 'support/login_helper'

class PlanCrudTest < Capybara::Rails::TestCase
  background do
    sign_in_with 'user_b@example.com', 'password'
  end

  test 'is created' do
    click_link 'PLANS'
    assert_equal(plans_path, current_path)
    click_link 'Add New Plan'

    assert_equal(new_plan_path, current_path)

    fill_in 'plan_name', with: 'New Plan'
    fill_in 'plan_virtual_dollars', with: '25.00'
    fill_in 'Interval', with: 4

    check 'Monday'
    check 'Tuesday'

    click_button 'Create Plan'

    page.must_have_content('New Plan')
    page.must_have_content('Monday')
    page.must_have_content('Tuesday')
    page.must_have_content('$100.00')
    page.wont_have_content('Wednesday')
    page.must_have_content('Plan successfully created!')
  end

  test 'is shown' do
    visit plan_path(plans(:plan_b))
    page.must_have_content('Company B')
    page.must_have_content('$200.00')
    page.must_have_content('Monday')
    page.must_have_content('Tuesday')
  end

  test 'is updated' do
    visit plan_path(plans(:plan_b))
    click_link 'Edit'
    fill_in 'Name', with: 'Updated plan name'
    fill_in 'plan_virtual_dollars', with: '5.00'
    click_button 'Update Plan'

    assert_equal(plan_path(plans(:plan_b)), current_path)

    page.must_have_content('Updated plan name')
    page.must_have_content('$50.00')
    page.must_have_content('Plan successfully updated!')
  end

  test 'is destroyed' do
    visit plans_path

    click_link 'Destroy'

    assert_equal(plans_path, current_path)
    page.must_have_content('Plan successfully destroyed.')
  end
end
