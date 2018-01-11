class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception # will uncomment this after views are implemented
  include ApplicationConcern
  include ErrorHandlers

  before_action :check_authentication
end
