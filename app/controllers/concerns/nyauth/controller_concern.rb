module Nyauth
  module ControllerConcern
    extend ActiveSupport::Concern
    include Nyauth::ApplicationHelper
    include Nyauth::SessionConcern
    include Nyauth::ClientConcern

    included do
      helper Nyauth::ApplicationHelper
    end
  end
end
