class GameWorker
  include Sidekiq::Worker
  sidekiq_options queue: :games

  def perform(game_id)
    service = Games::PlayService.new(game_id: game_id)

    service.perform
  end
end
