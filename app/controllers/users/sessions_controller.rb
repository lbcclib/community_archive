module Users
  class SessionsController < Devise::SessionsController
    def destroy
      # Preserve the saml_uid and saml_session_index in the session
      saml_uid = session['saml_uid']
      saml_session_index = session['saml_session_index']
      super do
        session['saml_uid'] = saml_uid
        session['saml_session_index'] = saml_session_index
      end
    end
  
    def after_sign_out_path_for(_)
	    Rails.logger.error("~~~~~~~~~~~ #{session['saml_uid']} && #{session['saml_session_index']} && #{IDP_METADATA[:idp_slo_service_url]}")
      if session['saml_uid'] && session['saml_session_index'] && IDP_METADATA[:idp_slo_service_url]
        user_saml_omniauth_authorize_path + "/spslo"
      else
        super
      end
    end
  end
end
