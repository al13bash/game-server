FactoryGirl.define do
  factory :account do
    amount_cents 1_500

    trait :in_usd do
      amount_currency 'USD'
    end

    trait :low_amount do
      amount_cents 100
    end
  end
end
