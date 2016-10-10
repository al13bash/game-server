class GamesController < ApplicationController
  def new
    @game = Game.new
    @accounts = current_user.accounts
  end

  def create
    @game = current_user.games.build(game_params)
    @game.bet_amount_currency = @game.account.amount_currency

    if @game.save
      connection.success(@game)
      Games::BaseService.new(@game).start
    else
      connection.failure
    end
  end

  private

  def connection
    Games::ActionCableConnections.instance.connection(current_user.id)
  end

  def game_params
    params.require(:game).permit(:bet_amount_cents, :account_id)
  end
end
