module Nyauth
  class PasswordsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    respond_to :html, :json
    before_action :set_client

    def edit
    end

    def update
      @client.attributes = client_params
      @client.save(context: :update_password)
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_update_password.call(client_name) || main_app.root_path)
    end

    private

    def set_client
      @client = client_class.find(current_authenticated.id)
    end

    def client_params
      params.fetch(client_name, {})
            .permit(:password, :password_confirmation)
    end
  end
end
