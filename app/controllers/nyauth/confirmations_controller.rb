module Nyauth
  class ConfirmationsController < ApplicationController
    allow_everyone
    self.responder = ConfirmationResponder
    respond_to :html, :json
    before_action :set_user

    def update
      @user.confirm
      respond_with(@user, location: root_path)
    end

    private

    def set_user
      @user = User.find_by!(confirmation_key: params[:confirmation_key])
    end
  end
end
