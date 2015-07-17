module Nyauth
  class AppResponder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::HttpCacheResponder

    # @see https://github.com/plataformatec/responders/issues/126
    def default_render
      if @default_response
        @default_response.call(options)
      else
        if Rails.version >= "5"
          controller.default_render(options) do
            raise ActionView::MissingTemplate.new([], "", [], true, [])
          end
        else
          controller.default_render(options)
        end
      end
    end
  end
end
