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

    # OPTIMEZE: :(
    def detect_url_helper(feature, client_name)
      @__methods ||= Nyauth::Engine.routes.url_helpers.instance_methods + Rails.application.routes.url_helpers.instance_methods
      @__candidates ||= @__methods.reject{|m| m =~ /rails_/}.map(&:to_s)
      detect_url_helper_for_app(feature, client_name) || detect_url_helper_for_nyauth(feature)
    end

    def detect_url_helper_for_nyauth(feature)
      path = @__candidates.grep(/\A#{feature}_path\z/).first
      return nil unless path
      nyauth.__send__(path)
    end

    def detect_url_helper_for_app(feature, client_name)
      if feature =~ /new_(.+)/
        path = @__candidates.grep(/\Anew_#{client_name}_#{$1}_path\z/).first
      else
        path = @__candidates.grep(/\A#{client_name}_#{feature}_path\z/).first
      end
      return nil unless path
      __send__(path)
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
