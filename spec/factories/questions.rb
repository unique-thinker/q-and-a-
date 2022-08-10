# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.sentences(number: 1) }
    body { Faker::Lorem.paragraph(sentence_count: 4) }
    tags { Faker::Lorem.words(number: 4) }
    user
  end
end
