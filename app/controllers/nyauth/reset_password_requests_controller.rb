module Nyauth
  class ResetPasswordRequestsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    allow_everyone
    respond_to :html, :json
    before_action :set_client, only: [:create]
    after_action :send_mail, only: [:create], if: -> { @client.reset_password_key.present? }

    def new
    end

    def create
      @client.request_reset_password
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_reset_password_request.call(client_name) || main_app.root_path)
    end

    private

    def set_client
      @client = client_class.find_by!(email: params[client_name][:email])
    rescue ActiveRecord::RecordNotFound
      render :new
    end

    def send_mail
      Nyauth::RequestMailer.request_reset_password(@client).deliver_now
    end
  end
end
