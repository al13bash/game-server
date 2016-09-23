class HomeController < ApplicationController
  def cabinet
    @user = current_user
  end
end
