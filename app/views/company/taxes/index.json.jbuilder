json.array!(@company_taxes) do |company_tax|
  json.extract! company_tax, :id, :name, :rate, :company_id
  json.url company_tax_url(company_tax, format: :json)
end
