module Nyauth
  class SessionsController < Nyauth::BaseController
    allow_everyone only: [:new, :create]
    before_action -> { require_authentication! as: nyauth_client_name }
    before_action :set_service

    def new
    end

    def create
      sign_in(@service.client) if @service.save(as: nyauth_client_name)
      redirect_path =  session.delete("#{nyauth_client_name}_return_to")
      respond_with @service,
                   location: redirect_path || \
                   Nyauth.configuration.redirect_path_after_sign_in.call(nyauth_client_name) || \
                   main_app.root_path
    end

    def destroy
      sign_out
      respond_with @service, location: Nyauth.configuration.redirect_path_after_sign_out.call(nyauth_client_name) || new_session_path_for(nyauth_client_name)
    end

    private

    def set_service
      @service = Nyauth::Session.new(session_service_params)
    end

    def session_service_params
      params.fetch(:session, {})
            .permit(:email, :password)
    end
  end
end
