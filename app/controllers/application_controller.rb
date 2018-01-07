class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception # will uncomment this after views are implemented

  before_action :require_login

  include ApplicationConcern
end
