# == Schema Information
#
# Table name: plans
#
#  id             :uuid             not null, primary key
#  company_id     :uuid             indexed
#  name           :string
#  interval       :integer          default(0), not null
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
#  total_price    :integer          default(0), not null
#  price_per_walk :integer          default(0), not null
#

class Plan < ApplicationRecord
  belongs_to :company

  validates :name, :company, :price_per_walk, :interval, presence: true
  validates :interval, :price_per_walk, numericality: { greater_than_or_equal_to: 0 }

  before_save :calculate_total_price

  delegate :name, to: :company, prefix: true

  def amount=(value)
    @amount = update(price_per_walk: value.to_money.cents)
  end

  def amount
    @amount = Money.new price_per_walk if price_per_walk
  end

  def calculate_total_price
    self.total_price = price_per_walk * interval
  end

  def days_and_values
    { monday: monday, tuesday: tuesday, wednesday: wednesday, thursday: thursday,
      friday: friday, saturday: saturday, sunday: sunday }
  end

  def selected_days_of_the_week
    days_and_values.select { |_, v| v == true }.keys
  end

  def scheduled_days
    selected_days_of_the_week.map { |d| d.to_s.capitalize }
  end
end
