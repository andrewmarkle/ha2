module TaxesHelper
  def taxes_are_set_up
    @_tax_set_up ||= current_company.tax
  end

  def company_tax_id
    current_company.tax.id
  end
end
