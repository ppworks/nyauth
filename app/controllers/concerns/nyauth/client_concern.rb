module Nyauth
  module ClientConcern
    extend ActiveSupport::Concern
    included do |base|
      next unless base.ancestors.include?(ActionController::Base)
      helper_method :nyauth_client_class
      helper_method :nyauth_client_name
    end

    def initialize
      @nyauth_client_classes = {}

      super
    end

    private

    def nyauth_mounted_path
      request.script_name.presence || "/#{request.path.split('/').try(:second)}"
    end

    # specify client class from nyauth_mounted_path
    def nyauth_client_class
      @nyauth_client_classes[nyauth_mounted_path] ||= nyauth_mounted_path[1..-1].classify.constantize
    rescue
      @nyauth_client_classes[nyauth_mounted_path] = User
    end

    def nyauth_client_name
      nyauth_client_class.name.underscore.to_sym
    end
  end
end
