require 'rails_helper'

RSpec.describe Tax, type: :model do
  context 'validations' do
    it { should validate_presence_of :company }
  end

  context 'associations' do
    it { should belong_to(:company) }
  end
end
