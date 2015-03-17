class Admin < ActiveRecord::Base
  include Nyauth::Authenticatable
end
