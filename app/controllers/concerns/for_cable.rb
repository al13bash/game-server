module ForCable
  def set_current_user_for_action_cable
    cookies.signed[:user_id] = current_user&.id
  end
end
