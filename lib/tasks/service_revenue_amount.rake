namespace :game_service do
  desc 'Reset revenue amount'
  task reset_revenue_amount: :environment do
    GameService.first.update(revenue_amount_cents: 0)
  end
end
