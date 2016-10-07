class UserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "channel_for_#{current_user.id}"
  end

  def unsubscribed
  end
end
