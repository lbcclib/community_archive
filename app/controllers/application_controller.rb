class ApplicationController < ActionController::Base
  helper Openseadragon::OpenseadragonHelper
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  include Hydra::Controller::ControllerBehavior

  # Adds Hyrax behaviors into the application controller
  include Hyrax::Controller
  include Hyrax::ThemedLayoutController
  with_themed_layout '1_column'


  protect_from_forgery with: :exception
  before_action :set_raven_context

  protected
  def set_raven_context
    params_hash = params.respond_to?(:to_unsafe_h) ? params.to_unsafe_h : params.to_hash
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params_hash, url: request.url)
  end
end
