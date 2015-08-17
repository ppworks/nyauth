module Nyauth
  class ConfirmationRequestsController < ApplicationController
    include Nyauth::ControllerConcern
    allow_everyone
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
    before_action :set_confirmation_request_service
    after_action :send_mail, only: [:create], if: -> { @confirmation_request_service.errors.blank? }

    def new
    end

    def create
      @confirmation_request_service.save(as: nyauth_client_name)
      respond_with(@confirmation_request_service, location: Nyauth.configuration.redirect_path_after_create_request_confirmation.call(nyauth_client_name) || main_app.root_path)
    end

    private

    def set_confirmation_request_service
      @confirmation_request_service = Nyauth::ConfirmationRequestService.new(confirmation_request_params)
    end

    def confirmation_request_params
      params.fetch(:confirmation_request_service, {})
            .permit(:email)
    end

    def send_mail
      Nyauth::RequestMailer.request_confirmation(@confirmation_request_service.client).deliver_now
    end
  end
end
