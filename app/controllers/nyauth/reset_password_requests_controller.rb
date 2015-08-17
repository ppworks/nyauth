module Nyauth
  class ResetPasswordRequestsController < ApplicationController
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
      respond_with(@service, location: Nyauth.configuration.redirect_path_after_reset_password_request.call(nyauth_client_name) || main_app.root_path)
    end

    private

    def set_service
      @service = Nyauth::ResetPasswordRequestService.new(reset_password_request_params)
    end

    def reset_password_request_params
      params.fetch(:reset_password_request_service, {})
            .permit(:email)
    end

    def send_mail
      Nyauth::RequestMailer.request_reset_password(@service.client).deliver_now
    end
  end
end
