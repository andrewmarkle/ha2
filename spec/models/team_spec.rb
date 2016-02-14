# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  company_id :integer          indexed
#  user_id    :integer          indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'
require 'support/shoulda_matchers_setup'

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
