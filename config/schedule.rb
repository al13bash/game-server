every 1.day, at: '6:00pm' do
  rake 'currency:restore_exchange'
end

every 1.day, at: '11:59 pm' do
  rake 'game_service:reset_revenue_amount'
end
