module Nyauth
  class SessionsController < ApplicationController
    include Nyauth::ControllerConcern
    before_action -> { require_authentication! as: nyauth_client_name }
    allow_everyone only: [:new, :create]
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
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
      @service = Nyauth::SessionService.new(session_service_params)
    end

    def session_service_params
      params.fetch(:session_service, {})
            .permit(:email, :password)
    end
  end
end
