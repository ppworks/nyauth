module Nyauth
  class BaseController < ApplicationController
    include Nyauth::ApplicationHelper
    helper Nyauth::ApplicationHelper
  end
end
