# == Schema Information
#
# Table name: taxes
#
#  id         :uuid             not null, primary key
#  name       :string
#  rate       :integer
#  company_id :uuid             indexed
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tax < ApplicationRecord
  belongs_to :company
  validates :company, presence: true
end
