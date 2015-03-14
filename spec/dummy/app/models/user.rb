class User < ActiveRecord::Base
  include Nyauth::Authenticatable
  include Nyauth::Confirmable
  include Nyauth::NewPasswordAbility
end
