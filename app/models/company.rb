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
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :teams
  has_many :teams, dependent: :destroy

  validates :owner, presence: true
  validates :name, presence: true
  validates :time_zone,
            inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }

end
