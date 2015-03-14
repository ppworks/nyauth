module Nyauth
  class SessionsController < ApplicationController
    allow_everyone only: [:new, :create]
    respond_to :html, :json
    before_action :set_session_service

    def new
    end

    def create
      sign_in(@session_service.client) if @session_service.save
      respond_with @session_service, location: root_path
    end

    def destroy
      sign_out
      respond_with @session_service, location: root_path
    end

    private

    def set_session_service
      @session_service = Nyauth::SessionService.new(session_service_params)
    end

    def session_service_params
      params.fetch(:session_service, {})
            .permit(:email, :password)
    end
  end
end
