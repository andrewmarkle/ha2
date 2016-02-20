# == Schema Information
#
# Table name: companies
#
#  id                     :integer          not null, primary key
#  name                   :string
#  url                    :string
#  phone_number           :string
#  owner_id               :integer          indexed
#  time_zone              :string
#  stripe_user_id         :string
#  stripe_access_token    :string
#  stripe_publishable_key :string
#  stripe_refresh_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'
require 'support/shoulda_matchers_setup'

RSpec.describe Company, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_inclusion_of(:time_zone).in_array(ActiveSupport::TimeZone.all.map(&:name)) }
  end

  context 'associations' do
    it { should have_many(:users) }
  end

  it "makes sure the url won't work withouht the http" do
    company = Company.new(url: "www.walkitoff.ca")
    expect(company.valid?).to be_falsey
    expect(company.errors[:url].any?).to be_truthy
  end

  it "makes it so the user must type in http" do
    company = Company.new(url: "http://www.walkitoff.ca")
    expect(company.valid?).to be_falsey
    expect(company.errors[:url].any?).to be_falsey
  end

  it "allows the url to be blank" do
    company = Company.new(url: "")
    expect(company.errors[:url].any?).to be_falsey
  end
end
