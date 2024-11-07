FactoryBot.define do
  factory :product do
    name { "Sample Product" }
    description { "This is a sample description." }
    price { 10.0 }
    stock { 5 }
  end
end
