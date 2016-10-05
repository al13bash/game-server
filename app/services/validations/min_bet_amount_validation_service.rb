module Validations
  class MinBetAmountValidationService < Validations::BaseValidationService
    def validation_method
      service = GameService.instance
      game.bet_amount_cents >= service.min_bet_amount_cents
    end
  end
end