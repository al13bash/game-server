class GameWorker
  include Sidekiq::Worker

  def perform(game_id)
    service = Games::PlayService.new(game_id: game_id)

    service.perform
  end
end
