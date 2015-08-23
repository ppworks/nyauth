class NotificationsController < ApplicationController
  before_action -> { require_authentication! as: :user }
  before_action -> { require_confirmation! as: :user }
end
