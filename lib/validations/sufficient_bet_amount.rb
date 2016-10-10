module Validations
  class SufficientBetAmount < Validations::Base
    def validation_method
      game.account.amount > game.bet_amount
    end
  end
end
