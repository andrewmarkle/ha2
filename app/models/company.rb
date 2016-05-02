# frozen_string_literal: true
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

class Company < ApplicationRecord
  has_many :users
  has_many :plans

  validates :name, presence: true, length: { maximum: 100 }
  validates_format_of :url, with: URI.regexp(%w(http https)), allow_blank: true
end
