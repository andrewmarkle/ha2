require "rails_helper"
require "support/login_helper"

feature "a User's Plan" do
  fixtures :all

  background do
    sign_in_with 'user_b@example.com', 'password'
  end

  scenario 'is created' do
    click_link "PLANS"
    expect(current_path).to eq(plans_path)
    click_link "Add New Plan"

    expect(current_path).to eq(new_plan_path)

    fill_in 'plan_name', with: 'New Plan'
    fill_in 'plan_virtual_dollars', with: '25.00'
    fill_in 'Interval', with: 4

    check "Monday"
    check "Tuesday"

    click_button 'Create Plan'

    expect(page).to have_text('New Plan')
    expect(page).to have_text('Monday')
    expect(page).to have_text('Tuesday')
    expect(page).to have_text('$100.00')
    expect(page).not_to have_text('Wednesday')
    expect(page).to have_text('Plan successfully created!')
  end

  scenario 'is shown' do
    visit plan_path(plans(:plan_b))
    expect(page).to have_text('Company B')
    expect(page).to have_text('$200.00')
    expect(page).to have_text('Monday')
    expect(page).to have_text('Tuesday')
  end

  scenario 'is updated' do
    visit plan_path(plans(:plan_b))
    click_link 'Edit'
    fill_in 'Name', with: 'Updated plan name'
    click_button 'Update Plan'

    expect(current_path).to eq(plan_path(plans(:plan_b)))

    expect(page).to have_text('Updated plan name')
    expect(page).to have_text('Plan successfully updated!')
  end

  scenario 'is destroyed' do
    visit plans_path

    click_link 'Destroy'

    expect(current_path).to eq(plans_path)
    expect(page).to have_text('Plan successfully destroyed.')
  end
end
