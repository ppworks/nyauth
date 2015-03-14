module Nyauth
  class ConfirmationsController < ApplicationController
    include Nyauth::ApplicationConcern
    include Nyauth::ClientConcern
    allow_everyone
    self.responder = ConfirmationResponder
    respond_to :html, :json
    before_action :set_client

    def update
      @client.confirm
      respond_with(@client, location: root_path)
    end

    private

    def set_client
      @client = client_class.find_by!(confirmation_key: params[:confirmation_key])
    end
  end
end
