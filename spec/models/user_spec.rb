require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  context 'associations' do
    it { should have_one(:company).through(:team) }
    it { should have_one(:team).dependent(:destroy) }
  end
end
