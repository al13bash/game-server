module Games
  class ActionCableConnector
    attr_reader :channel

    def initialize(user_id:)
      @channel = "channel_for_#{user_id}"
    end

    def failure
      ActionCable.server.broadcast(channel, data: 'failure')
    end

    def success
      ActionCable.server.broadcast(channel, data: 'success')
    end

    def transaction_failed
      ActionCable.server.broadcast(channel, data: 'transaction failed')
    end

    def transaction_completed
      ActionCable.server.broadcast(channel, data: 'transaction completed')
    end

    def transaction_in_progress
      ActionCable.server.broadcast(channel, data: 'transaction in progress')
    end
  end
end
