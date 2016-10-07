Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redistogo:575b78ca1e7be9c87c5461d456429ced@porgy.redistogo.com:9983/' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redistogo:575b78ca1e7be9c87c5461d456429ced@porgy.redistogo.com:9983/' }
end
