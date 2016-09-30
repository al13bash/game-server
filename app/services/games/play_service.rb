module Games
  class PlayService  
    BET_API_URL = 'https://www.random.org/integers/'

    attr_reader :game

    delegate :account, to: :game

    def initialize(game_id:)
      @game = Game.find(game_id)
    end

    def perform
      Game.transaction do
        init_bet_amount
        bet_amount_valid? ? process : @game.fail!
        connection.transaction_failed if @game.failure?
      end
    end

    def init_bet_amount
      game.update(bet_amount: Money.new(game.bet_amount_cents *
        currency.subunit_to_unit, currency))
    end

    def init_win_amount(win_amount:)
      game.update(win_amount: Money.new(win_amount *
        currency.subunit_to_unit, @currency))
    end

    def process
      game.proceed!
      connection.transaction_in_progress
      response = random_org_request
      init_win_amount(win_amount: response)
      game.complete!
      connection.transaction_completed
    end

    def random_org_request
      response = RestClient.get "#{BET_API_URL}?#{url_params}"
      response.body.to_i
    end

    def bet_amount_valid?
      account.amount > game.bet_amount
    end

    def currency
      @_currency ||= account.amount.currency
    end

    def connection
      @_connection ||= Games::ActionCableConnector.new(user_id: game.user_id)
    end

    def url_params
      @_url_params ||= {
        num: 1, min: 0, max: 2 * game.bet_amount.to_i,
        col: 1, base: 10, format: 'plain', rnd: 'new'
      }.to_query
    end
  end
end
