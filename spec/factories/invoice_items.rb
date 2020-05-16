FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 1, to: 1000) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    item
    invoice
  end
end
