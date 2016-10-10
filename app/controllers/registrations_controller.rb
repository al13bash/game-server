class RegistrationsController < Devise::RegistrationsController
  include ForCable

  def create
    super
    set_current_user_for_action_cable
  end
end
