module Nyauth
  class BaseController < Nyauth.configuration.parent_controller.constantize
    include Nyauth::ControllerConcern
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
  end
end
