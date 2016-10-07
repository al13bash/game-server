FactoryGirl.define do
  factory :game do
    bet_amount_cents 1000
  end

  factory :game_completed, parent: :game do
    bet_amount_cents 1000
    win_amount_cents 1500
    status :done
  end
end
