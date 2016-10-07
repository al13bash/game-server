require 'rails_helper'

RSpec.describe Games::ActionCableConnector do
  subject(:user) { create :user }

  describe 'creates ws connection' do
    it 'for particular user' do
      connection = described_class.new(user_id: user.id)

      expect(connection.channel).to eq("channel_for_#{user.id}")
    end
  end
end
