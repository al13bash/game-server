require 'rails_helper'

describe Validations::BlacklistValidationService do
  let!(:game) { create(:game_in_validation) }

  context 'valid response from RandomAPI' do
    it 'check out the game' do
      expect(described_class.new(game.id).validate).to eq(nil)
      expect(game.status).to eq('in_validation')
    end
  end

  context 'invalid response from RandomAPI' do
    it 'check out the game' do
      RandomApi::IntegerGenerator.any_instance.stub(:generate).and_return(0)

      expect(described_class.new(game.id).validate).to eq(0)
      expect(game.reload.status).to eq('failure')
    end
  end
end
