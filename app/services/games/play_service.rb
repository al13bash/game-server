module Games
  class PlayService
    attr_reader :game

    delegate :account, to: :game

    def initialize(game_id:)
      @game = Game.find(game_id)
    end

    def perform
      Game.transaction do
        init_bet_amount
        bet_amount_valid? ? process : transaction_failed
      end
    end

    def process
      transaction_in_progress
      init_win_amount(win_amount: generator.generate)
      transaction_completed
    end

    def bet_amount_valid?
      account.amount > game.bet_amount
    end

    def init_bet_amount
      game.update(bet_amount: Money.new(game.bet_amount_cents *
        currency.subunit_to_unit, currency))
    end

    def init_win_amount(win_amount:)
      game.update(win_amount: Money.new(win_amount *
        currency.subunit_to_unit, currency))
    end

    def transaction_failed
      game.fail!
      connection.transaction_failed
    end

    def transaction_in_progress
      game.proceed!
      connection.transaction_in_progress
    end

    def transaction_completed
      game.complete!
      connection.transaction_completed(game: game)
    end

    def generator
      @_generator = RandomApi::IntegerGenerator.new(max: game.bet_amount.to_i)
    end

    def currency
      @_currency ||= account.amount.currency
    end

    def connection
      @_connection ||= Games::ActionCableConnector.new(user_id: game.user_id)
    end
  end
end
