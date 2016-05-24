require 'test_helper'
require 'support/login_helper'

class PlanScopingTest < Capybara::Rails::TestCase
  test "display's only User A's records" do
    sign_in_with 'user_a@example.com', 'password'
    visit plans_path
    page.must_have_content 'This plan belongs to Company A'
    page.wont_have_content 'This plan belongs to Company B'
  end

  test "display's only user B's records" do
    sign_in_with 'user_b@example.com', 'password'
    visit plans_path
    page.must_have_content 'This plan belongs to Company B'
    page.wont_have_content 'This plan belongs to Company A'
  end

  test "can see User A's plan" do
    sign_in_with 'user_a@example.com', 'password'
    company_a = User.find_by(email: 'user_a@example.com').company
    plan = company_a.plans.first
    visit plan_path(plan)
    page.must_have_content(plan.name)
  end

  test "cannot see User B's plan" do
    sign_in_with 'user_a@example.com', 'password'
    company_b = User.find_by(email: 'user_b@example.com').company
    plan = company_b.plans.first
    visit plan_path(plan)
    page.must_have_content('Plan not found.')
    assert_equal(root_path, current_path)
  end
end
