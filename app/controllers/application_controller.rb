class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :model_list
  
  before_action :set_russian_locale
  
  #function for getting values from session
  def get_session_value(id)
    return session[id]
  end
  
  #function for setting values to session
  def set_session_value(id, value)
    session[id] = value
  end
  
  #list of models
  def model_list
    return model_list = ['clients', 'couriers', 'orders', 'contact_types']
  end
  
  def set_russian_locale
    I18n.locale = :ru
  end
end
