FactoryGirl.define do
  factory :project do
    sequence(:title)        {|n| "#{Faker::Company.bs}-#{n}"}
    sequence(:description)  {|n| "#{Faker::Lorem.paragraph}-#{n}"}
    due_date                "2020-04-04"
  end
end
