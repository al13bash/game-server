module Validations
  class BaseValidationService
    attr_reader :game

    def initialize(game_id)
      @game = Game.find(game_id)
    end

    def validate
      if game.in_validation?
        result = validation_method
        proceed_validation_result(result)
      else
        false
      end
    end

    def proceed_validation_result(result)
      if result
        decrement_validations_count
        check_validations_count
      else
        game.fail!
        notify_user
      end
    end

    def play
      binding.pry
      GameWorker.perform_async(game.id)
    end

    def decrement_validations_count
      game.decrement!(:validations_count)
    end

    def check_validations_count
      if game.validations_count == 0
        puts 'count 0'
        play
      end
    end

    def notify_user
      connection.validation_failed
    end

    def connection
      @_connection ||= Games::ActionCableConnector.new(user_id: game.user_id)
    end
  end
end
