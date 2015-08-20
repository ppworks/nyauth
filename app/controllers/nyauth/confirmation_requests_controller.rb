module Nyauth
  class ConfirmationRequestsController < ApplicationController
    include Nyauth::ControllerConcern
    allow_everyone
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
    before_action :set_service
    after_action :send_mail, only: [:create], if: -> { @service.errors.blank? }

    def new
    end

    def create
      @service.save(as: nyauth_client_name)
      respond_with(@service, location: Nyauth.configuration.redirect_path_after_create_request_confirmation.call(nyauth_client_name) || main_app.root_path)
    end

    private

    def set_service
      @service = Nyauth::ConfirmationRequest.new(confirmation_request_params)
    end

    def confirmation_request_params
      params.fetch(:confirmation_request, {})
            .permit(:email)
    end

    def send_mail
      Nyauth::RequestMailer.request_confirmation(@service.client)
                           .__send__(Nyauth.configuration.mail_delivery_method)
    end
  end
end
