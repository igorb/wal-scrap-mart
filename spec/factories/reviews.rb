# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    text { Faker::Commerce.department(7) }
  end
end
