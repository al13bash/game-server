class HomeController < ApplicationController
  def cabinet
    @user = current_user
    @games = current_user.games.order({ created_at: :desc })
  end
end
