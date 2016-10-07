module Games
  class ActionCableConnections
    include Singleton

    attr_reader :connections

    def initialize
      @connections = {}
    end

    def connection(user_id)
      connections[user_id] ||= create_connection(user_id)
    end

    private

    def create_connection(user_id)
      Games::ActionCableConnector.new(user_id: user_id)
    end
  end
end
