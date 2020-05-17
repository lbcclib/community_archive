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

  before_action :prepare_exception_notifier

  private

  def prepare_exception_notifier
    request.env['exception_notifier.exception_data'] = {
      current_user: current_user,
      referer: request.referer
    }
  end
end
