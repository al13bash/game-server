module Ratings
  class RatingChecker
    include Concerns::CurrencyExchanger

    attr_reader :game, :top, :top_min, :game_win_amount

    def initialize(game)
      @game = game
      @top = Rating.top
      @top_min = top.minimum(:score_cents)
      @game_win_amount = exchange_to_eur(game.win_amount)
    end

    def update_rating!
      if top_is_not_full?
        Rating.create!(game: game, score: game_win_amount)
      elsif top_min < game_win_amount
        top_min.update!(game: game, score: game_win_amount)
      end
    end

    private

    def top_is_not_full?
      top_min.nil? || top.size < Rating::RATING_TOP_AMOUNT
    end
  end
end
