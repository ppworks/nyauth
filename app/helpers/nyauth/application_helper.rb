module Nyauth
  module ApplicationHelper
    def method_missing method, *args, &block
      if method =~ /(_url|_path)\z/
        main_app.send(method, *args)
      else
        super
      end
    end

    def root_path
      if main_app.respond_to?(:root_path)
        main_app.__send__(:root_path)
      else
        '/'
      end
    end
  end
end
