class ValidationWorker
  include Sidekiq::Worker

  sidekiq_options queue: :validations

  sidekiq_options retry: 3

  sidekiq_retries_exhausted do |message|
    connection.failure

    @game.fail!
  end

  def perform(game_id, service_name)
    @game_id = game_id

    service = service_name.constantize

    service.new(game_id).validate
  end

  def connection
    @game = Game.find(@game_id)

    ActionCableConnections.instance.connection(@game.user_id)
  end
end
