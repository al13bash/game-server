FactoryGirl.define do
  factory :game do
    bet_amount_cents 1000
  end

  factory :game_in_validation, parent: :game do
    status :in_validation
    validations_count 20
    trait :in_usd do
      bet_amount_currency 'USD'
    end
  end

  factory :game_max_bet_amount_invalid, parent: :game_in_validation do
    bet_amount_cents 2000
  end

  factory :game_min_bet_amount_invalid, parent: :game_in_validation do
    bet_amount_cents 20
  end
end
