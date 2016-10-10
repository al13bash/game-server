class SessionsController < Devise::SessionsController
  include ForCable

  def create
    set_current_user_for_action_cable
    super
  end

  def destroy
    cookies.signed[:user_id] = ''
    super
  end
end
