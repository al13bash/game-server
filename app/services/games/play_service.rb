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

    private

    def process
      transaction_in_progress
      init_win_amount(win_amount: generator(game.bet_amount.to_i * 2).generate)
      update_account_and_service
      transaction_completed unless game.failure?
    end

    def update_account_and_service
      ActiveRecord::Base.transaction do
        account = Account.lock.find(game.account_id)
        service = GameService.lock.instance

        if account.amount < game.bet_amount
          transaction_failed
        else
          account.amount += game.win_amount - game.bet_amount
          account.save!

          service.revenue_amount += exchange_to_eur(game.bet_amount -
            game.win_amount)
          service.save!
        end
      end
    end

    def exchange_to_eur(amount)
      currency_code = amount.currency.iso_code
      return amount if currency_code == 'EUR'

      rate = CurrencyExchange.instance.send(currency_code.downcase)
      Money.add_rate(currency_code, 'EUR', rate)

      amount.exchange_to('EUR')
    end

    def init_win_amount(win_amount:)
      game.update(win_amount: Money.new(win_amount *
        currency.subunit_to_unit, currency))
    end

    def transaction_failed
      game.fail!
      connection.transaction_failed(game)
    end

    def transaction_in_progress
      game.proceed!
      connection.transaction_in_progress(game)
    end

    def transaction_completed
      game.complete!
      connection.transaction_completed(game)
    end

    def generator(max)
      RandomApi::IntegerGenerator.new(max: max)
    end

    def currency
      @_currency ||= account.amount.currency
    end

    def connection
      Games::ActionCableConnections.instance.connection(game.user_id)
    end
  end
end
