require 'rails_helper'
require 'support/login_helper'

feature 'Plan scoping' do
  fixtures :all

  context 'index' do
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

  context 'show' do
    context "when signed in as User A's company" do
      before do
        sign_in_with 'user_a@example.com', 'password'
      end

      it "can see User A's plan" do
        company_a = User.find_by(email: 'user_a@example.com').company
        plan = company_a.plans.first
        visit plan_url(plan)
        expect(page).to have_content(plan.name)
      end

      it "cannot see User B's plan" do
        company_b = User.find_by(email: 'user_b@example.com').company
        plan = company_b.plans.first
        visit plan_url(plan)
        expect(page).to have_content('Plan not found.')
        expect(page.current_url).to eq(root_url)
      end
    end
  end
end
