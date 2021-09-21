redis_conn = { url: ENV['REDIS_URL'] }

Sidekiq.configure_server do |s|
	s.redis = redis_conn
end

