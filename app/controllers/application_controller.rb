class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def index
    logger.debug "********************************* stuff goes here *********************"
  end
  
end
