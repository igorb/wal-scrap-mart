# frozen_string_literal: true

FactoryGirl.define do
  factory :product do
    url { Faker::Internet.url }
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end
end
