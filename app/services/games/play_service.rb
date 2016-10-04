module Games
  class PlayService
    attr_reader :game

    delegate :account, to: :game

    def initialize(game_id:)
      @game = Game.find(game_id)
    end

    def perform
      Game.transaction do
        validate? ? process : transaction_failed
      end
    end

    def validate?
      bet_amount_valid? and !user_in_blacklist?
    end

    def process
      transaction_in_progress
      init_win_amount(win_amount: generator(game.bet_amount.to_i * 2).generate)
      update_account
      transaction_completed unless game.failure?
    end

    def update_account
      ActiveRecord::Base.transaction do
        acc = Account.lock.find(game.account_id)
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

    def user_in_blacklist?
      true if generator(500).generate == 0
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

    def generator(max)
      @_generator = RandomApi::IntegerGenerator.new(max: max)
    end

    def currency
      @_currency ||= account.amount.currency
    end

    def connection
      @_connection ||= Games::ActionCableConnector.new(user_id: game.user_id)
    end
  end
end
