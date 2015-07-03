Nyauth.configure do |config|
  config.encryption_secret = ENV['NYAUTH_ENCRYPTION_SECRET']
  config.confirmation_expire_limit = 1.hour
  config.reset_password_expire_limit = 1.hour
  config.redirect_path do |urls|
    # config.redirect_path_after_sign_in = -> (client_name) {
    #  if client_name == :admin
    #    urls.admin_secret_notes_path
    #  else
    #    urls.root_path
    #  end
    #}
    # config.redirect_path_after_sign_in = -> (client_name) {}
    # config.redirect_path_after_sign_out = -> (client_name) {}
    # config.redirect_path_after_registration = -> (client_name) {}
    # config.redirect_path_after_create_request_confirmation = -> (client_name) {}
    # config.redirect_path_after_update_confirmation = -> (client_name) {}
    # config.redirect_path_after_reset_password_request = -> (client_name) {}
    # config.redirect_path_after_reset_password = -> (client_name) {}
    # config.redirect_path_after_update_password = -> (client_name) {}
  end
end
