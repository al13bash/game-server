Devise.setup do |config|
  config.secret_key = 'c8787e28b8622c5c692e16e7015549873eb4e3baa26da128be001d8c94fc257975e186382d778a9930462e3901986bc4f4bc2b758e937df874e0a69623f54fa2'

  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.sign_out_via = :delete
end
