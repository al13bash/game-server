module Validations
  class BlacklistValidationService < Validations::BaseValidationService
    def validation_method
      generator(500).generate != 0
    end

    private

    def generator(max)
      RandomApi::IntegerGenerator.new(max: max)
    end
  end
end
