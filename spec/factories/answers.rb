# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { Faker::Lorem.paragraph(sentence_count: 4) }
    question
    user
  end
end
