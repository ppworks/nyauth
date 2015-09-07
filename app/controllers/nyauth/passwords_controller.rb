module Nyauth
  class PasswordsController < Nyauth::BaseController
    before_action -> { require_authentication! as: nyauth_client_name }
    before_action :set_client

    def edit
    end

    def update
      @client.attributes = client_params
      @client.save(context: :update_password)
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_update_password.call(nyauth_client_name) || main_app.root_path)
    end

    private

    def set_client
      @client = nyauth_client_class.find(current_authenticated.id)
    end

    def client_params
      params.fetch(nyauth_client_name, {})
            .permit(:password, :password_confirmation)
    end
  end
end
