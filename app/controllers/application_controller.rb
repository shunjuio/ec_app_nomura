class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_params, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i(last_name first_name))
  end
end
