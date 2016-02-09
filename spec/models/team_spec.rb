require 'rails_helper'

RSpec.describe Team, type: :model do
  context 'validations' do
    it { should validate_presence_of :company }
    it { should validate_presence_of :user }
  end

  context 'associations' do
    it { should belong_to :company }
    it { should belong_to :user }
  end
end
