class GameError < ApplicationRecord
  belongs_to :game
  belongs_to :app_error
end
