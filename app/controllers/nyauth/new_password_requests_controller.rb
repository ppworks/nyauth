module Nyauth
  class NewPasswordRequestsController < ApplicationController
    allow_everyone
    respond_to :html, :json
    before_action :set_user, only: [:create]
    after_action :send_mail, only: [:create], if: -> { @user.new_password_key.present? }

    def new
    end

    def create
      @user.request_new_password
      respond_with(@user, location: root_path)
    end

    private

    def set_user
      @user = User.find_by!(email: params[:user][:email])
    rescue ActiveRecord::RecordNotFound
      render :new
    end

    def send_mail
      Nyauth::UserMailer.request_new_password(@user).deliver_now
    end
  end
end
