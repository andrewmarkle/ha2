# == Schema Information
#
# Table name: plans
#
#  id             :integer          not null, primary key
#  company_id     :integer          indexed
#  name           :string
#  interval       :integer
#  monday         :boolean          default(FALSE), not null
#  tuesday        :boolean          default(FALSE), not null
#  wednesday      :boolean          default(FALSE), not null
#  thursday       :boolean          default(FALSE), not null
#  friday         :boolean          default(FALSE), not null
#  saturday       :boolean          default(FALSE), not null
#  sunday         :boolean          default(FALSE), not null
#  taxable        :boolean          default(FALSE), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  total_price    :integer
#  price_per_walk :integer
#

class Plan < ApplicationRecord
  belongs_to :company

  validates :name, :company, :total_price, :price_per_walk, :interval, presence: true
  validates :total_price, :interval, :price_per_walk, numericality: { greater_than_or_equal_to: 0 }
end
