module ApplicationHelper
  def login_path
    if ENV.fetch("SSO_ENABLED", false)
      main_app.user_saml_omniauth_authorize_path
    else
      main_app.new_user_session_path
    end
  end
end
