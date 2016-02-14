json.array!(@plans) do |plan|
  json.extract! plan, :id, :company_id, :name, :interval, :price, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday, :taxable
  json.url plan_url(plan, format: :json)
end
