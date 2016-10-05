module Validations
  class SufficientBetAmountValidationService < Validations::BaseValidationService
    def validation_method
      game.account.amount > game.bet_amount
    end
  end
end
