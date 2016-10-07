module ApplicationHelper
  def authentication_buttons
    if user_signed_in?
      content_tag :li, class: 'nav-item' do
        link_to 'Sign out', destroy_user_session_path,
          method: :delete, class: 'nav-link'
      end
    else
      content = content_tag :li, class: 'nav-item' do
        link_to 'Sign up', new_user_registration_path, class: 'nav-link'
      end
      content << content_tag(:li, class: 'nav-item') do
        link_to 'Sign in', new_user_session_path, class: 'nav-link'
      end
    end
  end
end
