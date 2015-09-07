module Nyauth
  class ConfirmationsController < Nyauth::BaseController
    allow_everyone
    self.responder = ConfirmationResponder

    before_action :set_client

    def update
      @client.confirm
      respond_with(@client, location: Nyauth.configuration.redirect_path_after_update_confirmation.call(nyauth_client_name) || main_app.root_path)
    end

    private

    def set_client
      @client = nyauth_client_class.find_by!(confirmation_key: params[:confirmation_key])
    end
  end
end
