module Validations
  class BlacklistValidation < Validations::BaseValidation
    def validation_method
      generator(500).generate.nonzero?
    end

    private

    def generator(max)
      RandomApi::IntegerGenerator.new(max: max)
    end
  end
end
