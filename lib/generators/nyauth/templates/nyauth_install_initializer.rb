Nyauth.configure do |config|
  config.redirect_path do |urls|
    # config.redirect_path_after_sign_in = urls.admin_secret_notes_path
    # config.redirect_path_after_sign_out = urls.root_path
    # config.redirect_path_after_registration = urls.root_path
  end
end
