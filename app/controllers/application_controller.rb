class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  def set_locale
    if params[:locale]
      session[:locale] = params[:locale]
    end
    session[:locale] ||=  "pt-BR"
    I18n.locale = session[:locale]
  end
  
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User 
      profile_path(resource_or_scope)
    else
      super
    end
  end
  
end
