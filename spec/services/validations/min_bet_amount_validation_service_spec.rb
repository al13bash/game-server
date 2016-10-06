require 'rails_helper'

describe Validations::MinBetAmountValidationService do
  context 'game with valid bet amount' do
    let(:game) { Fabricate(:game_in_validation) }

    it 'check out the game' do
      expect(described_class.new(game.id).validate).to eq(nil)
      expect(game.status).to eq('in_validation')
    end
  end

  context 'game with invalid bet amount' do
    let(:game) { Fabricate(:game_min_bet_amount_invalid) }

    it 'check out the game' do
      expect(described_class.new(game.id).validate).to eq(0)
      expect(Game.last.status).to eq('failure')
    end
  end
end
