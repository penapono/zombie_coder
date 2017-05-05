# frozen_string_literal: true

FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Item #{n}" }
    sequence(:ammount) { |n| n }
    sequence(:points) { |n| n }
    survivor

    trait :invalid do
      name nil
      ammount nil
      points nil
    end
  end
end
