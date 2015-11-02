FactoryGirl.define do
  factory :payment do
    loan
    amount 100.0
    post_at Date.today
  end
end