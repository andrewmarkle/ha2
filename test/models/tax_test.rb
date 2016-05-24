require 'test_helper'

class TaxTest < ActiveSupport::TestCase
  should validate_presence_of :company
  should belong_to(:company)

  test 'if taxes have been set up' do
    tax = Tax.new
    refute(tax.persisted?)
  end
end
