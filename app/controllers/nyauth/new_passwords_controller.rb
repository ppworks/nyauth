module Nyauth
  class NewPasswordsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    allow_everyone
    respond_to :html, :json
    before_action :set_client

    def edit
    end

    def update
      @client.update_new_password(client_params)
      respond_with(@client, location: nyauth.new_session_path)
    end

    private

    def set_client
      @client = client_class.find_by!(new_password_key: params[:new_password_key])
    end

    def client_params
      params.fetch(client_param_name, {})
            .permit(:password, :password_confirmation)
    end
  end
end
