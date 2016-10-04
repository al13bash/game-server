class RatingsController < ApplicationController
  def index
    @top_wins = Rating.order(score_cents: :desc)
  end
end
