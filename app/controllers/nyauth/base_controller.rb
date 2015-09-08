module Nyauth
  class BaseController < ApplicationController
    include Nyauth::ControllerConcern
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
  end
end
