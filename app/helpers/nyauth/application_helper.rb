module Nyauth
  module ApplicationHelper
    def method_missing method, *args, &block
      if method =~ /(_url|_path)\z/
        main_app.send(method, *args)
      else
        super
      end
    end
  end
end
