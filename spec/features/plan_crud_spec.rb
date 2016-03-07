require "rails_helper"
require "support/login_helper"

feature "a User's Plan" do
  fixtures :all

  background do
    sign_in_with 'user_b@example.com', 'password'
  end

  scenario 'is created' do
    click_link "Plans"
    expect(current_path).to eq(plans_path)
    click_link "Add New Plan"

    expect(current_path).to eq(new_plan_path)

    fill_in 'Name', with: 'New Plan'
    fill_in 'Price per walk', with: 2500
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
    expect(current_path).to eq(plan_path(Plan.last))
    expect(page).to have_link payment_url(Plan.last.payment_guid)
  end

  scenario 'is updated' do
  end

  scenario 'is destroyed' do
  end

  scenario "is scoped to the user's company"
end
