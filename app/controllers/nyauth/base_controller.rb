module Nyauth
  class BaseController < ActionController::Base
    include Nyauth::ControllerConcern
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
  end
end
