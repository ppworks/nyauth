module Nyauth
  class NewPasswordRequestsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    allow_everyone
    respond_to :html, :json
    before_action :set_client, only: [:create]
    after_action :send_mail, only: [:create], if: -> { @client.new_password_key.present? }

    def new
    end

    def create
      @client.request_new_password
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_new_password_request || main_app.root_path)
    end

    private

    def set_client
      @client = client_class.find_by!(email: params[client_name][:email])
    rescue ActiveRecord::RecordNotFound
      render :new
    end

    def send_mail
      Nyauth::RequestMailer.request_new_password(@client).deliver_now
    end
  end
end
