module Nyauth
  module ClientConcern
    extend ActiveSupport::Concern
    included do |base|
      helper_method :client_class
    end

    def initialize
      @client_classes = {}
      super
    end

    private

    def mounted_path
      request.script_name.presence || "/#{request.path.split('/').try(:second)}"
    end

    # specify client class from mounted_path
    def client_class
      @client_classes[mounted_path] ||= mounted_path[1..-1].classify.constantize
    rescue
      @client_classes[mounted_path] = User
    end

    def client_name
      client_class.name.underscore.to_sym
    end
  end
end
