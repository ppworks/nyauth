module Nyauth
  module ApplicationHelper
    def method_missing method, *args, &block
      if method =~ /(.+)_path_for\z/
        detect_url_helper($1, *args)
      elsif method =~ /(_url|_path)\z/
        main_app.send(method, *args)
      else
        super
      end
    end

    def detect_url_helper(feature, client_name)
      @__methods ||= Nyauth::Engine.routes.url_helpers.instance_methods + Rails.application.routes.url_helpers.instance_methods
      @__candidates ||= @__methods.reject{|m| m =~ /rails_/}.map(&:to_s)
      helper_name = @__candidates.grep("#{client_name}_#{feature}_path").first || @__candidates.grep("#{feature}_path").first
      return unless helper_name

      __send__ helper_name
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
