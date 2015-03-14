module Nyauth
  class RegistrationsController < ApplicationController
    allow_everyone
    respond_to :html, :json
    before_action :set_user

    def new
    end

    def create
      sign_in(@user) if @user.save
      respond_with(@user, location: root_path)
    end

    private

    def set_user
      @user = User.new(user_params)
    end

    def user_params
      params.fetch(:user, {})
            .permit(:email, :password, :password_confirmation)
    end
  end
end
