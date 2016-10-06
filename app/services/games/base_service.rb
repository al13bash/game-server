module Games
  class BaseService
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def start
      game.run_validation!

      game.update(validations_count: validations_list.count)

      validations_list.each do |validation_name|
        ValidationWorker.perform_async(game.id, validation_name)
      end
    end

    private

    def validations_list
      %w[
        Validations::BlacklistValidationService
        Validations::SufficientBetAmountValidationService
        Validations::MaxBetAmountValidationService
        Validations::MinBetAmountValidationService
      ]
    end
  end
end
