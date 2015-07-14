module Nyauth
  module Test
    module ControllerMacros
      include Nyauth::SessionConcern

      def self.included(base)
        base.instance_eval do
          before do
            @request.env['nyauth'] = Nyauth::Nyan.new(@request.env)
          end
        end
      end
    end
  end
end
