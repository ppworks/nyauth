class AnotherApplicationController < ActionController::Base
  include Nyauth::ControllerConcern
  protect_from_forgery with: :exception
end
