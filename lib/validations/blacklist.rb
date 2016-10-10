module Validations
  class Blacklist < Validations::Base
    def validation_method
      generator(500).generate.nonzero?
    end

    def error_type
      :user_in_blacklist
    end

    private

    def generator(max)
      RandomApi::IntegerGenerator.new(max: max)
    end
  end
end
