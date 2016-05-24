# == Schema Information
#
# Table name: plans
#
#  id             :uuid             not null, primary key
#  company_id     :uuid             indexed
#  name           :string
#  interval       :integer          default(0), not null
#  monday         :boolean          default(FALSE), not null
#  tuesday        :boolean          default(FALSE), not null
#  wednesday      :boolean          default(FALSE), not null
#  thursday       :boolean          default(FALSE), not null
#  friday         :boolean          default(FALSE), not null
#  saturday       :boolean          default(FALSE), not null
#  sunday         :boolean          default(FALSE), not null
#  taxable        :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  total_price    :integer          default(0), not null
#  price_per_walk :integer          default(0), not null
#

require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  should validate_presence_of(:name)
  should validate_presence_of(:price_per_walk)
  should validate_presence_of(:interval)
  should validate_presence_of(:company)
  should validate_numericality_of(:price_per_walk).is_greater_than_or_equal_to(0)
  should validate_numericality_of(:interval).is_greater_than_or_equal_to(0)
  should belong_to :company

  test 'returns false for all the booleans on initialization' do
    plan = Plan.new
    refute(plan.monday)
    refute(plan.tuesday)
    refute(plan.wednesday)
    refute(plan.thursday)
    refute(plan.friday)
    refute(plan.saturday)
    refute(plan.sunday)
    refute(plan.taxable)
  end

  test 'calculates the total_price based on the interval and price_per_walk' do
    plan = Plan.new(interval: 10, price_per_walk: 2500)
    plan.calculate_total_price
    assert_equal(25_000, plan.total_price)
  end

  test 'shows all of the selected (true) days of the week' do
    plan = Plan.new(monday: true, tuesday: true)
    assert_equal(%w(Monday Tuesday), plan.scheduled_days)
  end

  test 'tests value as integer' do
    plan = Plan.new(virtual_dollars: 19)
    assert_equal(1900, plan.price_per_walk)
  end

  test 'tests value as a fraction' do
    plan = Plan.new(virtual_dollars: 19.99)
    assert_equal(1999, plan.price_per_walk)
  end

  test 'tests value as a string' do
    plan = Plan.new(virtual_dollars: '19')
    assert_equal(1900, plan.price_per_walk)
  end

  test 'tests value as a string with a dollar sign' do
    plan = Plan.new(virtual_dollars: '$19.99')
    assert_equal(1999, plan.price_per_walk)
  end

  test 'tests value as a string with decimal' do
    plan = Plan.new(virtual_dollars: '19.99')
    assert_equal(1999, plan.price_per_walk)
  end

  test 'saves converts the virtual dollar attribute to integers in the database' do
    company = create(:company)
    plan = create(:plan, virtual_dollars: 19.99, interval: 2, company: company)
    plan.calculate_total_price

    assert_equal(1999, plan.price_per_walk)
    assert_equal(3998, plan.total_price)
  end
end
