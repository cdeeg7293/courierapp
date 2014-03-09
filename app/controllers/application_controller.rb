class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #function for getting values from session
  def get_session_value(id)
    return session[id]
  end
  
  #function for setting values to session
  def set_session_value(id, value)
    session[id] = value
  end
end
