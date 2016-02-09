class Company < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :users, through: :teams
  has_many :teams, dependent: :destroy

  validates :owner, presence: true
  validates :name, presence: true
  validates :time_zone,
            inclusion: { in: ActiveSupport::TimeZone.all.map(&:name) }

end
