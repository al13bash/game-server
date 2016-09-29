class GamesController < ApplicationController
  def new
    @game = Game.new
    @accounts = current_user.accounts
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      render 'new', notice: 'Game created'
    else
      render 'new'
    end
  end

  private

  def game_params
    params.require(:game).permit(:bet_amount_cents, :account_id)
  end
end
