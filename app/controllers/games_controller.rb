class GamesController < ApplicationController
  def new
    @game = Game.new
    @accounts = current_user.accounts
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      GameWorker.perform_async(@game.id)
      connection.success
    else
      connection.failure
    end
  end

  private

  def connection
    @_connection ||= Games::ActionCableConnector.new(user_id: current_user.id)
  end

  def game_params
    params.require(:game).permit(:bet_amount_cents, :account_id)
  end
end
