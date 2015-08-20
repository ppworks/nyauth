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
                  :confirmation_expire_limit,
                  :reset_password_expire_limit,
                  :password_minium,
                  :password_digest_stretches,
                  :encryption_secret,
                  :mail_delivery_method


    def initialize
      @redirect_path_after_sign_in = Proc.new {}
      @redirect_path_after_sign_out = Proc.new {}
      @redirect_path_after_registration = Proc.new {}
      @redirect_path_after_create_request_confirmation = Proc.new {}
      @redirect_path_after_update_confirmation = Proc.new {}
      @redirect_path_after_reset_password_request = Proc.new {}
      @redirect_path_after_reset_password = Proc.new {}
      @redirect_path_after_update_password = Proc.new {}
      @confirmation_expire_limit = 1.hour
      @reset_password_expire_limit = 1.hour
      @password_minium = 8
      @password_digest_stretches = 1000
      @encryption_secret = ENV['NYAUTH_ENCRYPTION_SECRET']
      @mail_delivery_method = :deliver_now
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
