class PostsController < ApplicationController
  before_action -> { require_authentication! as: :user }

  def index
  end
end
