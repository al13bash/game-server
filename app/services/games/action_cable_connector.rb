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

    def success
      broadcast(channel, data: 'success')
    end

    def transaction_failed
      broadcast(channel, data: 'transaction failed')
    end

    def transaction_completed(game:)
      partial = GamesController.renderer.render(file: '/games/_game',
                                                formats: [:html],
                                                locals: { game: game },
                                                layout: false)
      broadcast(channel, data: 'transaction completed', partial: partial)
    end

    def transaction_in_progress
      broadcast(channel, data: 'transaction in progress')
    end
  end
end
