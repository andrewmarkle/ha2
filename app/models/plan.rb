# == Schema Information
#
# Table name: plans
#
#  id             :uuid             not null, primary key
#  company_id     :uuid             indexed
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

  validates :name, :company, :price_per_walk, :interval, presence: true
  validates :interval, :price_per_walk, numericality: { greater_than_or_equal_to: 0 }

  delegate :name, to: :company, prefix: true

  def calculate_total_price_of_plan
    price_per_walk * interval
  end

  def days
    { monday: monday, tuesday: tuesday, wednesday: wednesday, thursday: thursday,
      friday: friday, saturday: saturday, sunday: sunday }
  end

  def days_of_the_week
    days.select {|k,v| v == true }.keys
  end

  def scheduled_days
    days_of_the_week.map { |d| d.to_s.capitalize }
  end
end
