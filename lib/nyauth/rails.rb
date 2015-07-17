require 'nyauth/route'
module ActionDispatch::Routing
  class Mapper
    prepend Nyauth::Route
  end
end
