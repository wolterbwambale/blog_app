class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :bio, :posts_counter, :email, :password) }
    deuvise_parameter_sanitizer.permit(:account_update) do |u|
      .permit(:name, :photo, :bio, :posts_counter, :email, :password, :current_password)
    end
  end
end
