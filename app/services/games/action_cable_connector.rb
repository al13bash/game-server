module Games
  class ActionCableConnector
    attr_reader :channel, :server

    delegate :broadcast, to: :server

    def initialize(user_id:)
      @channel = "channel_for_#{user_id}"
      @server = ActionCable.server
    end

    def failure
      broadcast(channel, data: 'failure')
    end

    def success(game)
      broadcast(channel, status: 'game_created',
                         game_partial: game_partial(game))
    end

    def validation_failed(game)
      broadcast(channel, status: 'validation_failed',
                         game_id: game.id,
                         game_status: game.status)
    end

    def transaction_failed(game)
      broadcast(channel, status: 'transaction_failed',
                         game_id: game.id,
                         game_status: game.status)
    end

    def transaction_completed(game)
      broadcast(channel, status: 'transaction_completed',
                         accounts: game.user.accounts_hash,
                         game_id: game.id,
                         game_partial: game_partial(game))
    end

    def transaction_in_progress(game)
      broadcast(channel, status: 'transaction_in_progress',
                         game_id: game.id,
                         game_status: game.status)
    end

    private

    def game_partial(game)
      GamesController.renderer.render(file: '/games/_game',
                                      formats: [:html],
                                      locals: { game: game },
                                      layout: false)
    end
  end
end
