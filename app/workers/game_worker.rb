class GameWorker
  include Sidekiq::Worker

  sidekiq_options queue: :games

  sidekiq_options retry: 3

  sidekiq_retries_exhausted do |_message|
    connection.failure

    @game.fail!
  end

  def perform(game_id)
    @game_id = game_id

    service = Games::PlayService.new(game_id: game_id)

    service.perform
  end

  def connection
    @game = Game.find(@game_id)

    ActionCableConnections.instance.connection(@game.user_id)
  end
end
