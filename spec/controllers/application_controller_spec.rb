require 'rails_helper'

RSpec.describe ApplicationController do
  it_behaves_like 'Nyauth::SessionConcern'
end
