module Games
  class PlayService
    attr_reader :game

    delegate :account, to: :game

    def initialize(game_id:)
      @game = Game.find(game_id)
    end

    def perform
      Game.transaction do
        bet_amount_valid? ? process : transaction_failed
      end
    end

    def process
      transaction_in_progress
      init_win_amount(win_amount: generator.generate)
      update_account
      transaction_completed unless game.failure?
    end

    def update_account
      acc = account.lock!('FOR SHARE')
      acc.with_lock('FOR UPDATE') do
        if acc.amount < game.bet_amount
          transaction_failed
        else
          acc.amount += game.win_amount - game.bet_amount
          acc.save!
        end
      end
    end

    def bet_amount_valid?
      account.amount > game.bet_amount
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
      connection.transaction_in_progress(game)
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
