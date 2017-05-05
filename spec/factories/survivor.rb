# frozen_string_literal: true

FactoryGirl.define do
  factory :survivor do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:age) { |n| n }
    gender 0
    latitude "-22.8260663"
    longitude "-47.083327"

    trait :invalid do
      name nil
      age nil
      gender nil
      latitude nil
      longitude nil
    end
  end
end
