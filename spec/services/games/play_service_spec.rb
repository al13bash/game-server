require 'rails_helper'

RSpec.describe Games::PlayService do
  subject(:user) { create :user }
  let(:action) { described_class.new(game_id: game.id).perform }

  context 'handles a process of playing a game' do
    subject(:account) { create :account, user_id: user.id }
    subject!(:game) do
      create :game_in_validation,
        user_id: user.id, account_id: account.id
    end

    it 'changes daily revenue' do
      expect { action }
        .to change { GameService.instance.revenue_amount_cents }
        .from(0)
    end

    it 'changes account amount' do
      amount = game.account.amount_cents
      expect { action }
        .to change { game.reload.account.amount_cents }
        .from(amount)
    end

    it 'changes win amount' do
      expect { action }.to change { game.reload.win_amount_cents }.from(0)
    end

    it 'changes status to done' do
      expect { action }
        .to change { game.reload.status }
        .from('in_validation').to('done')
    end
  end

  context 'account amount is lower than bet amount' do
    subject(:account) { create :account, :low_amount, user_id: user.id }
    subject!(:game) do
      create :game_in_validation,
        user_id: user.id, account_id: account.id
    end

    it 'fails and changes status to failure' do
      expect { action }
        .to change { game.reload.status }
        .from('in_validation').to('failure')
    end
  end

  context 'game currency is not default' do
    let!(:currency_exchange) { create :currency_exchange }
    subject(:account) { create :account, :in_usd, user_id: user.id }
    subject!(:game) do
      create :game_in_validation, :in_usd,
        user_id: user.id, account_id: account.id
    end

    it 'exchanges game result before adding to daily revenue' do
      action
      game.reload
      expect(GameService.instance.revenue_amount_cents)
        .not_to eq(game.bet_amount_cents - game.win_amount_cents)
    end
  end
end
