class User < ActiveRecord::Base
  include Nyauth::Authenticatable
  include Nyauth::Confirmable
end
