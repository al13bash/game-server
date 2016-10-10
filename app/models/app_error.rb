class AppError < ApplicationRecord
  has_many :game_errors
  has_many :games, through: :game_errors
end
