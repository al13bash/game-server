module Validations
  class SufficientBetAmountValidation < Validations::BaseValidation
    def validation_method
      game.account.amount > game.bet_amount
    end
  end
end
