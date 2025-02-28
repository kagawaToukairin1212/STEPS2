class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  helper_method :current_user, :logged_in?
  before_action :require_login
  add_flash_types :success, :danger

  private

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to login_path, alert: "ログインが必要です"
    end
  end

  def not_authenticated
    redirect_to login_path
  end
end
