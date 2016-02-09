require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'validations' do
    it { should validate_presence_of :owner }
    it { should validate_presence_of :name }
    it { should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }
  end

  context 'associations' do
    it { should have_many(:users).through(:teams) }
    it { should have_many(:teams).dependent(:destroy) }
    it { should belong_to :owner }
  end
end
