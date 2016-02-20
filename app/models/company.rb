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

class Company < ApplicationRecord
  has_many :users

  validates :name, presence: true
  validates :time_zone,
            inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }

  validates_format_of :url, :with => URI::regexp(%w(http https)), allow_blank: true
end
