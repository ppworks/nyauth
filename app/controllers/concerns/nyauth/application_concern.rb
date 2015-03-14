module Nyauth
  module ApplicationConcern
    extend ActiveSupport::Concern
    include Nyauth::ApplicationHelper

    included do
      helper Nyauth::ApplicationHelper
    end
  end
end
