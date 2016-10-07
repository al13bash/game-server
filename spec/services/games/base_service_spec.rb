require 'rails_helper'

RSpec.describe Games::BaseService do
  let(:user) { create :user }
  let(:account) { create :account, user_id: user.id }

  context 'initialized with game' do
    let(:action) { described_class.new(game).start }
    let!(:game) { create :game, user_id: user.id, account_id: account.id }

    it 'changes game status to in_validation' do
      expect { action }
        .to change { game.reload.status }
        .from('pending')
        .to('in_validation')
    end

    it 'changes validations_count' do
      expect { action }
        .to change { game.reload.validations_count }
        .from(nil)
    end
  end
end
