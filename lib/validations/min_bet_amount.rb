module Validations
  class MinBetAmount < Validations::Base
    def validation_method
      service = GameService.instance
      game.bet_amount_cents >= service.min_bet_amount_cents
    end

    def error_type
      :min_bet_amount_is_not_reached
    end
  end
end
