class HomeController < ApplicationController
  def cabinet
    @user = current_user
    @games = current_user.games.last_twenty
  end
end
