Fabricator(:game) do
  bet_amount_cents 1000
end

Fabricator(:game_in_validation, from: :game) do
  status :in_validation
  validations_count 20
end

Fabricator(:game_max_bet_amount_invalid, from: :game_in_validation) do
  bet_amount_cents 2000
end

Fabricator(:game_min_bet_amount_invalid, from: :game_in_validation) do
  bet_amount_cents 20
end
