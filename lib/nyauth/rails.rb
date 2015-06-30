require 'nyauth/route'
module ActionDispatch::Routing
  class Mapper
    include Nyauth::Route

    def initialize_with_nyauth(*args)
      initialize_without_nyauth(*args)
      nyauth_concerns
    end
    alias_method_chain :initialize, :nyauth
  end
end
