Nyauth::Engine.routes.draw do
  concerns :nyauth_registrable
  concerns :nyauth_sessionable
  concerns :nyauth_passwordable
  concerns :nyauth_confirmable
  Nyauth.configuration.setup_redirect_path
end
