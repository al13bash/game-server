module Validations
  class BlacklistValidationService < Validations::BaseValidationService
    def validation_method
      generator(500).generate.nonzero?
    end

    private

    def generator(max)
      RandomApi::IntegerGenerator.new(max: max)
    end
  end
end
