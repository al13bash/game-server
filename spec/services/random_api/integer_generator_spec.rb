require 'rails_helper'

RSpec.describe RandomApi::IntegerGenerator do
  describe 'ask random.org API for a random integer' do
    it 'return integer in range from 0 to initialized max value' do
      value = described_class.new(max: 300).generate

      expect(value).to be_between(0, 300).inclusive
    end
  end
end
