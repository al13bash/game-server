module Validations
  class MaxBetAmount < Validations::Base
    def validation_method
      max_bet_amount >= game.bet_amount_cents
    end

    def error_type
      :max_bet_amount_exceeded
    end

    private

    def max_bet_amount
      service = GameService.instance

      if service.revenue_amount_cents.positive?
        service.revenue_amount_cents.to_f / 2 + service.min_bet_amount_cents
      else
        service.min_bet_amount_cents
      end
    end
  end
end
