module Nyauth
  class ConfirmationRequestsController < ApplicationController
    include Nyauth::ControllerConcern
    allow_everyone
    self.responder = Nyauth::AppResponder
    respond_to :html, :json
    before_action :set_client, only: [:create]
    after_action :send_mail, only: [:create], if: -> { @client.confirmation_key.present? }

    def new
    end

    def create
      @client.request_confirmation
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_create_request_confirmation.call(client_name) || main_app.root_path)
    end

    private

    def set_client
      @client = client_class.find_by!(email: params[client_name][:email])
    rescue ActiveRecord::RecordNotFound
      render :new
    end

    def send_mail
      Nyauth::RequestMailer.request_confirmation(@client).deliver_now
    end
  end
end
