require 'rails_helper'

RSpec.describe Ratings::RatingChecker do
  let(:user) { create :user }
  let(:account) { create :account, user_id: user.id }
  let(:games) do
    create_list :game_completed, 10, user_id: user.id, account_id: account.id
  end
  let(:action) { games.each { |e| described_class.new(e).update_rating! } }

  context 'rating is empty' do
    it 'changes rating top count' do
      expect { action }
        .to change { Rating.top.size }
        .from(0)
        .to(10)
    end
  end

  context 'rating is full' do
    context 'game with bigger win amount' do
      let(:game) do
        create :game_completed, user_id: user.id,
                                account_id: account.id,
                                win_amount_cents: 1700
      end

      it 'updates rating' do
        action
        expect { described_class.new(game).update_rating! }
          .to change { Rating.top.last }
      end
    end

    context 'game with lower win amount' do
      let(:game) do
        create :game_completed, user_id: user.id,
                                account_id: account.id,
                                win_amount_cents: 800
      end

      it 'doesn\'t update rating' do
        action
        expect { described_class.new(game).update_rating! }
          .not_to change { Rating.top.last }
      end
    end
  end
end
