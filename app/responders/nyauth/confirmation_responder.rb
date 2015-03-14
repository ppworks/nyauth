module Nyauth
  class ConfirmationResponder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder

    def get?
      false
    end

    def default_action
      :edit
    end
  end
end
