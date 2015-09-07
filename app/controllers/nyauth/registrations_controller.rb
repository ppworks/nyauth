module Nyauth
  class RegistrationsController < Nyauth::BaseController
    allow_everyone
    before_action :set_service

    def new
    end

    def create
      sign_in(@service.client) if @service.save(as: nyauth_client_name)
      respond_with @service, location: Nyauth.configuration.redirect_path_after_registration.call(nyauth_client_name) || main_app.root_path
    end

    private

    def set_service
      @service = Nyauth::Registration.new(registration_params)
    end

    def registration_params
      params.fetch(:registration, {})
            .permit(:email, :password, :password_confirmation)
    end
  end
end
