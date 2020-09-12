FactoryBot.define do
  factory :user do
    login { |n| "My article #{n}" }
    name { "John Smith" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "github" }
  end
end
