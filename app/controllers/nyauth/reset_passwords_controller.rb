module Nyauth
  class ResetPasswordsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    allow_everyone
    respond_to :html, :json
    before_action :set_client

    def edit
    end

    def update
      @client.reset_password(client_params)
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_reset_password || new_session_path_for(client_name))
    end

    private

    def set_client
      @client = client_class.find_by!(reset_password_key: params[:reset_password_key])
    end

    def client_params
      params.fetch(client_name, {})
            .permit(:password, :password_confirmation)
    end
  end
end
