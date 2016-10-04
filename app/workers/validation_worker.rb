class ValidationWorker
  include Sidekiq::Worker
  sidekiq_options queue: :validations

  def perform(game_id, service_name)
    service = service_name.constantize

    service.new(game_id).validate
  end
end
