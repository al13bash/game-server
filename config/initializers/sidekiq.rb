if Rails.env.production?
  url = 'redis://redistogo:575b78ca1e7be9c87c5461d456429ced@porgy.redistogo.com:9983/'

  Sidekiq.configure_server do |config|
    config.redis = { url: url }
  end

  Sidekiq.configure_client do |config|
    config.redis = { url: url }
  end
end
