module Nyauth
  class NewPasswordsController < Nyauth::BaseController
    allow_everyone
    respond_to :html, :json
    before_action :set_user

    def edit
    end

    def update
      @user.update_new_password(user_params)
      respond_with(@user, location: nyauth.new_session_path)
    end

    private

    def set_user
      @user = User.find_by!(new_password_key: params[:new_password_key])
    end

    def user_params
      params.fetch(:user, {})
            .permit(:password, :password_confirmation)
    end
  end
end
