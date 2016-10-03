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
      broadcast(channel, status: 'game_created', game_partial: game_partial(game))
    end

    def transaction_failed
      broadcast(channel, data: 'transaction failed')
    end

    def transaction_completed(game:)
      ordered_accounts = game.user.ordered_accounts;

      accounts_select = GamesController.renderer.render(file: '/games/_accounts_select',
                                                formats: [:html],
                                                locals: { accounts: ordered_accounts },
                                                layout: false)

      accounts_list = GamesController.renderer.render(file: '/home/_accounts_list',
                                                formats: [:html],
                                                locals: { accounts: ordered_accounts },
                                                layout: false)
      broadcast(channel,
                status: 'transaction_completed',
                accounts_select: accounts_select,
                accounts_list: accounts_list,
                game_id: game.id,
                game_partial: game_partial(game))
    end

    def transaction_in_progress(game)
      broadcast(channel, status: 'transaction_in_progress',
                game_id: game.id, game_partial: game_partial(game))
    end

    def game_partial(game)
      GamesController.renderer.render(file: '/games/_game',
                                              formats: [:html],
                                              locals: { game: game },
                                              layout: false)
    end
  end
end
