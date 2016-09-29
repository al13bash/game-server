class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed

  end

  def create_game(data)
    puts data
  end
end
