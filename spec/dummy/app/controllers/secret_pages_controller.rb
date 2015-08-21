class SecretPagesController < ApplicationController
  before_action -> { require_authentication! as: :user }
end
