module Validations
  class Base
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

    private

    def proceed_validation_result(result)
      if result
        decrement_validations_count
        play if game.validations_count.zero?
      else
        validation_failed
        notify_user
      end
    end

    def validation_failed
      game.fail!
      GameError.create!(game_id: game.id, app_error_id: validation_error.id)
    end

    def play
      GameWorker.perform_async(game.id)
    end

    def decrement_validations_count
      ActiveRecord::Base.transaction do
        game.lock!.decrement!(:validations_count)
      end
    end

    def notify_user
      connection.validation_failed(game, validation_error.message)
    end

    def validation_error
      AppError.find_by!(kind: error_type)
    end

    def error_type
      :validation_failed
    end

    def connection
      Games::ActionCableConnections.instance.connection(game.user_id)
    end
  end
end
