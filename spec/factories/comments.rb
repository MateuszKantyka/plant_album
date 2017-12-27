FactoryBot.define do
  factory :comment do
    content 'example comment'
    car 'example car'
    cost "100"
    rating_general 5
    rating_cost 5
    rating_time 5
  end
end
