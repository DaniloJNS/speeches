sidekiq_config = { url: ENV.fetch('QUEUE_HOST') { 'redis://localhost:6380/0' } }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
