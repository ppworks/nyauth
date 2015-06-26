module Nyauth
  class Configuration
    attr_accessor :redirect_path_block,
                  :redirect_path_after_sign_in,
                  :redirect_path_after_sign_out,
                  :redirect_path_after_registration,
                  :redirect_path_after_create_request_confirmation,
                  :redirect_path_after_update_confirmation,
                  :redirect_path_after_reset_password_request,
                  :redirect_path_after_reset_password,
                  :redirect_path_after_update_password,
                  :password_minium,
                  :password_digest_stretches


    def initialize
      @redirect_path_after_sign_in = nil
      @redirect_path_after_sign_out = nil
      @redirect_path_after_registration = nil
      @redirect_path_after_create_request_confirmation = nil
      @redirect_path_after_update_confirmation = nil
      @redirect_path_after_reset_password_request = nil
      @redirect_path_after_reset_password = nil
      @redirect_path_after_update_password = nil
      @password_minium = 8
      @password_digest_stretches = 1000
      @redirect_path_block = Proc.new {}
    end

    def redirect_path(&block)
      @redirect_path_block = block
    end

    def setup_redirect_path
      UrlHelper.class_eval do
        include Rails.application.routes.url_helpers
      end
      @redirect_path_block.call(UrlHelper.new)
    end
  end

  class UrlHelper
  end
end
