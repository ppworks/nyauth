module Nyauth
  class RegistrationsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    allow_everyone
    respond_to :html, :json
    before_action :set_client

    def new
    end

    def create
      sign_in(@client) if @client.save
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_registration || main_app.root_path)
    end

    private

    def set_client
      @client = client_class.new(client_params)
    end

    def client_params
      params.fetch(client_param_name, {})
            .permit(:email, :password, :password_confirmation)
    end
  end
end
