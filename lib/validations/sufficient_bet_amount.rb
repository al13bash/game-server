module Validations
  class SufficientBetAmount < Validations::Base
    def validation_method
      game.account.amount > game.bet_amount
    end

    def error_type
      :insufficient_funds_in_account
    end
  end
end
