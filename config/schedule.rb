require 'tzinfo'

def local(time)
  TZInfo::Timezone.get('Europe/Minsk').local_to_utc(Time.parse(time))
end

every 1.day, at: '6:00pm' do
  rake 'currency:restore_exchange'
end

every 1.day, at: local('11:59 pm') do
  rake "game_service:reset_revenue_amount"
end
