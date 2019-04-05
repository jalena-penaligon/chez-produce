class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_visitor, :current_admin, :current_merchant

  def render_not_found
    render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
  
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_merchant
    current_user && current_user.merchant?
  end

    def current_admin
      current_user && current_user.admin?
    end
end
