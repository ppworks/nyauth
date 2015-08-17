module Nyauth
  class RegistrationsController < ApplicationController
    include Nyauth::ControllerConcern
    allow_everyone
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
    before_action :set_registration_service

    def new
    end

    def create
      sign_in(@registration_service.client) if @registration_service.save(as: nyauth_client_name)
      respond_with @registration_service, location: Nyauth.configuration.redirect_path_after_registration.call(nyauth_client_name) || main_app.root_path
    end

    private

    def set_registration_service
      @registration_service = Nyauth::RegistrationService.new(registration_params)
    end

    def registration_params
      params.fetch(:registration_service, {})
            .permit(:email, :password, :password_confirmation)
    end
  end
end
