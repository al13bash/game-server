require 'rails_helper'

RSpec.describe Games::ActionCableConnections do
  subject(:user_one) { create :user }
  subject(:user_two) { create :user }

  before(:each) do
    @connections = described_class.instance
  end

  describe 'cache for Games::ActionCableConnector objects' do
    it 'creates connection for user (if it doesn\'t exist)' do
      connection = @connections.connection(user_one.id)

      expect(@connections.connection(user_one.id)).to eq(connection)
    end

    it 'saves a connection for each user (if requested)' do
      @connections.connection(user_two.id)

      expect(@connections.connections.size).to eq(2)
    end
  end
end
