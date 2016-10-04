module Games
  class PlayService
    attr_reader :game

    delegate :account, to: :game

    def initialize(game_id:)
      @game = Game.find(game_id)
    end

    def perform
      Game.transaction do
        process
      end
    end

    def process
      transaction_in_progress
      init_win_amount(win_amount: generator(game.bet_amount.to_i * 2).generate)
      update_account_and_service
      transaction_completed unless game.failure?
    end

    def update_account_and_service
      ActiveRecord::Base.transaction do
        account = Account.lock.find(game.account_id)
        service = GameService.lock.first

        if account.amount < game.bet_amount
          transaction_failed
        else
          account.amount += game.win_amount - game.bet_amount
          account.save!

          service.revenue_amount_cents += game.bet_amount - game.win_amount
          service.save!
        end
      end
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
      RandomApi::IntegerGenerator.new(max: max)
    end

    def currency
      @_currency ||= account.amount.currency
    end

    def connection
      @_connection ||= Games::ActionCableConnector.new(user_id: game.user_id)
    end
  end
end
