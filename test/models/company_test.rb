# == Schema Information
#
# Table name: companies
#
#  id                     :uuid             not null, primary key
#  name                   :string
#  url                    :string
#  phone_number           :string
#  stripe_user_id         :string
#  stripe_access_token    :string
#  stripe_publishable_key :string
#  stripe_refresh_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  should have_many(:users)
  should validate_presence_of :name

  test "makes sure the url won't work withouht the http" do
    company = Company.new(url: 'www.walkitoff.ca')
    refute(company.valid?)
    assert(company.errors[:url].any?)
  end

  test 'makes it so the user must type in http' do
    company = Company.new(url: 'http://www.walkitoff.ca')
    refute(company.valid?)
    refute(company.errors[:url].any?)
  end

  test 'allows the url to be blank' do
    company = Company.new(url: '')
    refute(company.errors[:url].any?)
  end
end
