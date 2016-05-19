module MoneyHelper
  def cents_to_dollars(number)
    number_to_currency(number.to_f / 100)
  end
end
