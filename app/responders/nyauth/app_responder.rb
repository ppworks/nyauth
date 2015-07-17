module Nyauth
  class AppResponder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder

    # @see https://github.com/plataformatec/responders/issues/126
    def default_render
      if @default_response
        @default_response.call(options)
      else
        controller.render(options)
      end
    end
  end
end
