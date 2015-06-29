require 'nyauth/route'
module ActionDispatch::Routing
  class Mapper
    include Nyauth::Route
  end
end
