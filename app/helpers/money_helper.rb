module MoneyHelper
  def cents_to_dollars(number)
    number_to_currency(number.to_f / 100)
  end

  def formatted_price(amount)
    format('$%0.2f', amount / 100.0)
  end
end
