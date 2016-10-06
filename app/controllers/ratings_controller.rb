class RatingsController < ApplicationController
  def index
    @top_wins = Rating.top
  end
end
