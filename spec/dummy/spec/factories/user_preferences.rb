# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :user_preference do
    user nil
    key "MyString"
    value "MyString"
  end
end
