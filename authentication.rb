# authentication.rb
# Authentifizierung

load_template 'http://github.com/akl/rails-templates/raw/master/base.rb'

# GEM's
gem 'binarylogic-authlogic', :lib => 'authlogic', :source => 'http://gems.github.com'
gem 'makandra-aegis', :lib => 'aegis', :source => 'http://gems.github.com'

name = ask('Wie soll das Benutzer-Modell heissen?')
generate :session name



####
# Applikations-Dateien ersetzen/ergänzen
####

# app/controllers/application_controller.rb
file 'app/controllers/application_controller.rb',
%q{class ApplicationController < ActionController::Base
  include ExceptionNotifiable

  protect_from_forgery

  helper :all
  helper_method :logged_in?, :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation

  around_filter :handle_permission_error

  # Darf der Benutzer die angeforderte Seite/Funktion aufrufen?
  def handle_permission_error
    yield
  rescue Aegis::PermissionError
    # Bei mangelnden Rechten umleiten
    render _file => "#{RAILS_ROOT}/public/422.html", :status => :forbidden
  end

 protected

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def current_user
    @current_user ||= current_user_session and current_user_session.user
  end

  def current_user_session
    @current_user_session ||= UserSession.find
  end

  def logged_in?
    not current_user.nil?
  end

  def require_user
    unless logged_in?
      store_location
      flash[:notice] = "Bitte melden Sie sich an."
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if logged_in?
      store_location
      flash[:notice] = "Sie müssen sich abmelden um diese Seite sehen zu können."
      redirect_to account_url
      return false
    end
  end

end
}

