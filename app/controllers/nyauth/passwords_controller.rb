module Nyauth
  class PasswordsController < ApplicationController
    respond_to :html, :json
    before_action :set_user

    def edit
    end

    def update
      @user.attributes = user_params
      @user.save(context: :update_password)
      respond_with(@user, location: root_path)
    end

    private

    def set_user
      @user = User.find(current_authenticated.id)
    end

    def user_params
      params.fetch(:user, {})
            .permit(:password, :password_confirmation)
    end
  end
end
