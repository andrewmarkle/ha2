# == Schema Information
#
# Table name: plans
#
#  id             :integer          not null, primary key
#  company_id     :integer          indexed
#  name           :string
#  interval       :integer
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
#  total_price    :integer
#  price_per_walk :integer
#

require 'rails_helper'
require 'support/shoulda_matchers_setup'

RSpec.describe Plan, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:price_per_walk) }
    it { should validate_presence_of(:interval) }
    it { should validate_presence_of(:company) }
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:price_per_walk).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:interval).is_greater_than_or_equal_to(0) }
  end

  context 'associations' do
    it { should belong_to :company }
  end

  describe 'initialization' do
    it 'returns false for all the booleans' do
      plan = Plan.new
      expect(plan.monday).to eq(false)
      expect(plan.tuesday).to eq(false)
      expect(plan.wednesday).to eq(false)
      expect(plan.thursday).to eq(false)
      expect(plan.friday).to eq(false)
      expect(plan.saturday).to eq(false)
      expect(plan.sunday).to eq(false)
      expect(plan.taxable).to eq(false)
    end
  end
end
