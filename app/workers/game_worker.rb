class GameWorker
  include Sidekiq::Worker

  def perform(game_id)
    Game.transaction do
      @game = Game.find(game_id)
      @account = @game.account

      init_game
      bet_amount_valid? ? process : @game.fail!
    end
  end

  def process
    @game.proceed!
    response = random_org_request
    @game.update(win_amount_cents: response *
      @account.amount.currency.subunit_to_unit)
    @game.complete!
  end

  def random_org_request
    url = 'https://www.random.org/integers/'
    url_params = {
      num: 1, min: 0, max: 2 * @game.bet_amount.to_i,
      col: 1, base: 10, format: 'plain', rnd: 'new'
    }.to_query
    response = RestClient.get "#{url}?#{url_params}"
    response.body.to_i
  end

  def init_game
    @game.win_amount_currency = @account.amount.currency
    @game.bet_amount_currency = @account.amount.currency
    @game.bet_amount_cents *= @account.amount.currency.subunit_to_unit
    @game.save
  end

  def bet_amount_valid?
    @account.amount > @game.bet_amount
  end
end
