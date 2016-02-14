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

class Team < ApplicationRecord
  belongs_to :company
  belongs_to :user

  validates :company, presence: true
  validates :user, presence: true
end
