module Validations
  class MaxBetAmountValidationService < Validations::BaseValidationService
    def validation_method
      max_bet_amount >= game.bet_amount_cents
    end

    private

    def max_bet_amount
      service = GameService.instance
      service.revenue_amount_cents.to_f / 2 + service.min_bet_amount_cents
    end
  end
end
